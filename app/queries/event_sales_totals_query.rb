class EventSalesTotalsQuery
  
  # TODO This query is wrong and should be replaced. Outer join is not appropriate
  
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
        :event_id => row['event_id'].to_i,
        :event_title => row['event_title'],
        :event_starts_at => DateTime.parse( row['event_starts_at']).in_time_zone,
        :total_base_price => row['total_base_price'].to_f,
        :total_service_charge => row['total_service_charge'].to_f,
        :total => row['total'].to_f,
        :day_of => row['day_of'] == 't' ? true : false, 
        :tickets_sold => row['tickets_sold'].to_i,
        :tickets_checked_in => row['tickets_checked_in'].to_i
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
      tickets.event_id as event_id, 
      events.title as event_title,
      events.starts_at as event_starts_at,
      sum(tickets.base_price) as total_base_price, 
      sum(tickets.service_charge) total_service_charge, 
      sum( (tickets.base_price + tickets.service_charge)) as total,
      CASE 
         WHEN orders.purchased_at > (events.starts_at - interval '1 day') THEN true else false 
      END as day_of,
      count(tickets) as tickets_sold,
      sum(case when tickets.checked_in_at IS NOT NULL then 1 else 0 end) as tickets_checked_in
      FROM tickets
      INNER JOIN events
      ON tickets.event_id = events.id
      INNER JOIN orders
      ON tickets.order_id = orders.id
      WHERE orders.purchased_at IS NOT null
      AND orders.account_id = #{@account_id}
      GROUP BY event_id, event_title, events.starts_at, day_of
      ORDER BY event_starts_at ASC
      
    }
  end
end