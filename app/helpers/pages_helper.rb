module PagesHelper
  
  def render_shortcodes(html)
    events_list_regex = /\[events_list cat=\&[a-z]+;([a-z0-9]+)\&[a-z]+;\]/
    
    if (match = events_list_regex.match(html))
      
       cat = match[1]

       @events = @current_account.events.current.cat(cat).limit(100).order('starts_at asc')
       
       injection_html = ''
       if @events
         injection_html = render(:partial => 'front/events/events', :locals => {:events => @events, :cat => cat })
        else
          injection_html = "Did not find category <strong>#{$1}</strong>"
       end
      
      html.gsub!( events_list_regex, injection_html )
    end
    html
  end
end
