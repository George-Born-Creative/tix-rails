module EventsHelper
  def youtube_resize(embed_url, opts = {})
    
    defaults = {:width => 250, :height => 250}
    
    opts.reverse_merge!(defaults)
    
    code =  /embed\/([a-zA-Z0-9]+)/.match(embed_url)[1]
    
    "<iframe width='#{opts[:width]}' height='#{opts[:height]}' src='http://www.youtube.com/embed/#{code}' frameborder='0' allowfullscreen></iframe>".html_safe
  end
    
end
