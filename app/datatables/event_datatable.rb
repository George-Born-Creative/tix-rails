class EventDatatable
  delegate :params, :h, :link_to, :image_tag, :number_to_currency, :edit_event_url,  to: :@view

  def initialize(view, current_account_id)
    @view = view
    @account = Account.find current_account_id
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @account.events.count,
      iTotalDisplayRecords: events.count,
      aaData: data,
      sortColumn: sort_column,
      sortDirection: sort_direction
    }
  end

private

  def data
    events.map do |event|
      
      [
        event.cat,
        link_to(event.title, edit_event_url(event)),
        (event.starts_at.nil? ? nil : event.starts_at.to_formatted_s(:date)),
        (event.starts_at.nil? ? nil : event.starts_at.to_formatted_s(:time)),
        (event.starts_at.nil? ? nil : event.starts_at.to_formatted_s(:weekday)),
        event.price_freeform,
        event.set_times,
        link_to('Edit', edit_event_url(event), :class => 'btn')
        
      ]
    end
  end

  def events
    @events ||= fetch_events
  end

  def fetch_events
    # puts "####{sort_column} #{sort_direction}"
    
    events = @account.events.order("#{sort_column} #{sort_direction}").page(page).per(per_page)
    
    if params[:sSearch].present?
      events = events.where("title ILIKE :search", search: "%#{params[:sSearch]}%")
    end
    
    events
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[cat title starts_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end