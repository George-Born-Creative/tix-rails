module EventsHelper
  def youtube_resize(embed_url, opts = {})
    
    defaults = {:width => 250, :height => 250}
    
    opts.reverse_merge!(defaults)
    
    code =  /embed\/([a-zA-Z0-9-]+)/.match(embed_url)
    
    unless code.nil? || code[1].nil?
      "<iframe width='#{opts[:width]}' height='#{opts[:height]}' src='http://www.youtube.com/embed/#{code[1]}' frameborder='0' allowfullscreen></iframe>".html_safe
    end
  end
   
   def artist_social_bar(artist)
     render :partial => 'front/artists/social_bar', :locals => {:artist => artist}
   end 
   
end
