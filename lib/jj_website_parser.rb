require 'rubygems'
require 'nokogiri'
require 'open-uri'
require  'pp'
require 'yaml'
require 'ostruct'

class JJWebsiteParser

  attr_accessor :events
  
  EVENTS_URL = 'http://jamminjava.com/home/shaun-data/events.xml'
  ARTIST_BASE_URL = 'http://jamminjava.com/home/shaun-data/artists.xml'
  OUTPUT_FILE = 'artists.yml'


  def initialize(account_subdomain)
    puts '### Initializing...'
    
    @events = []
    
    @account = Account.find_by_subdomain(account_subdomain)
  end
  
  def process!
    puts '### Processing!...'
    
    events = self.xml_to_array(EVENTS_URL, 'event')
    
    events.each do |event|
      @events.push( process_event( event) ) 
    end
    
  end
  


  ##################

  # Input: existing event fields
  # Maps existing event fields to new event fileds, 
  # formatting and disgarding as necessary  
  # Requests fetching and saving of Artists as needed
  # Saves event object to database
  
  ##################
  
  def process_event(event)
    new_event = OpenStruct.new
    
    new_event.title = event['title']
    new_event.starts_at = Time.at event['event-date'].to_i
    new_event.body = event['event-descrip']
    new_event.price_freeform = event['price']
    new_event.set_times = event['set-times']
    new_event.info = event['additional-info']
                                                           
    new_event.supporting_act_1 = event['supporting-act-1'] 
    new_event.supporting_act_2 = event['supporting-act-2'] 
    new_event.supporting_act_3 = event['supporting-act-3'] 
    
    new_event.headliner = fetch_and_create_artist( event['artist-id'] )
        
    new_event = strip_whitespace( new_event )
    
    puts "CREATING EVENT #{new_event.title}"
    
    return @account.events.create!( new_event.marshal_dump )
        
    
    
  end
  
  def fetch_and_create_artist(jj_artist_id)
    id = jj_artist_id
    existing_artist = @account.artists.find_by_id_old(jj_artist_id)
    
    unless existing_artist.nil?
      puts "EXISTING ARTIST #{existing_artist.name}"
      return existing_artist
    else
      artist = xml_to_array( artist_url(id), 'artist')
      puts "CREATING ARTIST #{artist[0]['artist-name']}"
      return process_artist( artist[0], jj_artist_id )    
    end
    
  end
  
  def process_artist(artist, old_id)
    new_artist = OpenStruct.new 
    
    new_artist.id_old = old_id
    
    new_artist.name = artist['artist-name']
    new_artist.body = artist['artist-descrip']
    new_artist.myspace_url = artist['artist-myspace-url']
    new_artist.url = artist['artist-url']
    new_artist.facebook_url = artist['artist-facebook-url']
    new_artist.audio_sample_url = artist['artist-audio-sample-url']
    # artist['artist-audio-sample-title']
    new_artist.video_url = artist['artist-video-url']
    new_artist.twitter = artist['twitter']
    new_artist.youtube1 = artist['youtube1']
    new_artist.youtube2 = artist['youtube2']
    
    img_url = artist['artist-image'].strip
   
    new_artist = strip_whitespace( new_artist )
    
    a = @account.artists.new( new_artist.marshal_dump )
     unless img_url.empty?
        file = open(img_url)
        filename = File.basename(img_url)
        a.photo = file
        a.photo.instance_write :file_name, filename
        puts "### Setting photo to #{img_url}"
      end
    a.save!
    return a
  end
  
  def strip_whitespace(hash)
    hash.each do |k,v|
      if hash[k].class == String
        stripped = v.strip
        unless stripped.empty?
          hash[k] = stripped
        else
          hash[k] = nil
        end
      end
    end
    hash
  end

  def artist_url(id)
    "#{ARTIST_BASE_URL}/#{id.to_s}"
  end

  def xml_to_array(url, element_name) # returns an array of hashes
    page = Nokogiri::XML(open(url))
    nodes = page.search("//#{element_name}").to_a.map{|node| node.children.inject({}){|a,c| a[c.name] = c.text if c.class == Nokogiri::XML::Element; a}}
    nodes
  end
  

end

##############################
# EVENTS All original fields #
##############################
# title
# artist-id
# artist-secondary-id
# event-date
# event-descrip
# price
# buy-tickets-url
# sold-out
# supporting-act-1
# supporting-act-2
# supporting-act-3
# support-act-site
# on-sale
# set-times
# suggestion1
# suggestion2
# suggestion3
# suggestion4
# suggestion5
# suggestion6
# additional-info


##############################
# ARTISTS All original fields #
##############################

# artist-name
# artist-image
# artist-descrip
# artist-myspace-url
# artist-url
# artist-facebook-url
# artist-audio-sample-url
# artist-audio-sample-title
# artist-video-url
# twitter
# youtube1
# youtube2
