module PagesHelper
  
  
  # 1. For each shortcode
        # Scan for code
        # FOr each match
        # Capture groups 
        # Call function with prp
        # 
        
  
  
  
  def render_shortcodes(html)
    html = apply_events_list(html)
  end
  
  
  def apply_events_list(html)
    #events_list_regex = /\[events_list cat=\&[a-z]+;([a-z0-9]+)\&[a-z]+;\]/
    events_list_regex = /\[(events_list) cat=\&[a-z]+;([a-z0-9|]+[|]?)+\&[a-z]+;\]/

    html.gsub!(events_list_regex) do |match|
      cats = $2.split('|').map{|c| c.to_sym}
      @events = @current_account.events.cat(cats).current.order('starts_at ASC')      
      render(:partial => 'front/events/events', :locals => {:events => @events, :cat => 'C' })
    end
    
    html
  end
  
  
  
  
  
end
