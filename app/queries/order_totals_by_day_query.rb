class OrderTotalsByDayQuery
  
  # Returns array of hashes of all days
  # {"date"=>"2013-01-09 00:00:00", "count"=>"47", "total"=>"1992.00"}
  
  def initialize(account_id)
    @account_id = account_id
  end
  
  def exec
    res = ActiveRecord::Base.connection.execute( sanitized_query )
    postprocess_query(res)
  end
  
  private
  
  def postprocess_query(res)
    return res.map do |row|
      {
        :date => Date.parse( row['date'] ),
        :count => row['count'].to_i,
        :total => row['total'].to_f
      }
    end
  end
  
  def sanitized_query
    ActiveRecord::Base.send(:sanitize_sql_array, query_array)
  end
  
  def query
    # > Time.zone.formatted_offset
    # => "-05:00" 
    # > Time.zone.formatted_offset[-5,5]
    # => "-05:00"
    
    tz = "#{Time.zone.formatted_offset}"[-5,5]
    dir = "#{Time.zone.formatted_offset}"[0] == '-' ? '-' : '+' 
    
    date_str = "date_trunc('day',  purchased_at #{dir} '#{tz}':: interval ) "
    
    %Q{
      SELECT #{date_str} as date, count(*) as count, sum(total) as total
      FROM "orders" 
      WHERE (account_id = ? )
      AND (purchased_at IS NOT NULL) 
      GROUP BY #{date_str} 
      ORDER BY #{date_str} DESC
    }
  end
  
  def query_array
    [query, @account_id]
  end
  
end