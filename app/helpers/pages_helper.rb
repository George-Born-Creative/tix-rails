module PagesHelper
    # 1. For each shortcode
        # Scan for code
        # For each match
          # Capture groups 
          # Call function with params/args
  
  def render_shortcodes(html)
    html = apply_events_list(html)
  end
  
  def apply_events_list(html)
    #events_list_regex = /\[events_list cat=\&[a-z]+;([a-z0-9]+)\&[a-z]+;\]/
    regex = /\[(events_list) cat=\&[a-z]+;([a-z0-9|_]+[|]?)+\&[a-z]+;\]/

    html.gsub!(regex) do |match|
      cats = $2.split('|').map{|c| c.to_sym}
      @events = @current_account.events.cat(cats).current.announced.order('starts_at ASC')  
      render(:partial => 'front/events/events', locals: {events: @events, cats: cats})
    end
    
    html
  end
end
