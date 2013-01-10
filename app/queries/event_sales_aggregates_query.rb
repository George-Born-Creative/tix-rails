class EventSalesAggregatesQuery
  
  def initialize(account_id)
    @account_id = account_id
    
  end
  
  def exec
    res = ActiveRecord::Base.connection.execute( query_sanitized )
    @res = postprocess_query(res)
  end
  
  private

  def postprocess_query(res)
    return res.map do |row|
      {
        :starts_at => DateTime.parse( row['starts_at'] ).in_time_zone,
        :title => row['title'],
        :id => row['id'],
        :tickets_sold => row['tickets_sold'].to_i,
        :tickets_checked_in => row['tickets_checked_in'].to_i,
        :tickets_total => row['tickets_total'].to_f
      }
    end
  end
  
  def query_sanitized
    ActiveRecord::Base.send(:sanitize_sql_array, query_array)
  end
  
  def query_array
    [query, @account_id]
  end
  
  def query
    %Q{
      SELECT 
      	events.id, 
      	events.title, 
          events.starts_at, 
      	count(tickets) as tickets_sold, 
      	count(case when tickets.checked_in_at IS NOT NULL then 1 end) AS tickets_checked_in,
          sum(tickets.base_price) + sum(tickets.service_charge) as tickets_total
      FROM events
      LEFT OUTER JOIN tickets
      ON tickets.event_id = events.id
      LEFT OUTER JOIN orders
      ON tickets.order_id = orders.id 
      WHERE orders.purchased_at IS NOT null
      AND events.account_id = ?
      GROUP BY events.id, events.title
      ORDER BY events.starts_at ASC
    }
  end
end