# -*- encoding : utf-8 -*-
require 'json'
require './lib/svg_parser'
require 'date'


class Seed  
  def initialize
    @artist_url = 'http://jamminjava.com/home/shaun-data/artists.xml'
    @events_url = 'http://jamminjava.com/home/shaun-data/events.xml'
    
    @account = Account.find_or_initialize_by_subdomain('jamminjava')
    
  end
  
  def run_all
    Account.delete_all
    User.delete_all
    
    Chart.delete_all
    Area.delete_all
    
    Event.delete_all
    Artist.delete_all
    
    Ticket.delete_all
    
    Order.delete_all

    self.users
    self.charts
    self.events
    self.artists
    #self.tickets
    #self.orders
  end
  
  def run_second
    @account.charts.delete_all
    @account.tickets.delete_all
    
    self.charts
    self.areas
    
    self.tickets
    
  end
  
  def run_tickets_orders_only
    @account.tickets.delete_all
    @account.orders.delete_all
    
    self.tickets
    self.orders
  end
  
  def run_local
    
  end
  

  def users
    shaun = @account.users.create(  :first_name => 'Shaun',
                          :last_name => 'Robinson',
                          :email => 'shaun@squiid.com',
                          :password => ENV['DEFAULT_PASSWORD'],
                          :role => 'owner'
                       )
    puts "### Creating user #{shaun.full_name}"


    luke = @account.users.create(  :first_name => 'Luke',
                          :last_name => 'Brindley',
                          :email => 'lukebrindley@me.com',
                          :password => ENV['DEFAULT_PASSWORD'],
                          :role => 'owner'
                       )
               
    puts "### Creating user #{luke.full_name}"
               
    daniel = @account.users.create(  :first_name => 'Daniel',
                         :last_name => 'Brindley',
                         :email => 'daniel@goteammusic.com',
                         :password => ENV['DEFAULT_PASSWORD'],
                         :role => 'owner'
                      )

    puts "### Creating user #{daniel.full_name}"

    jonathan = @account.users.create(  :first_name => 'Jonathan',
                          :last_name => 'Brindley',
                          :email => 'jonathanbrindley@gmail.com',
                          :password => ENV['DEFAULT_PASSWORD'],
                          :role => 'owner'
                       )


    mai = @account.users.create(  :first_name => 'Mai',
                         :last_name => '',
                         :email => 'jjdoorgal@gmail.com',
                         :password => ENV['DEFAULT_PASSWORD'],
                         :role => 'employee'
                      )

    puts "### Creating user #{jonathan.full_name}"


    jonathan = @account.users.create(  :first_name => 'Raphael',
                          :last_name => 'Shamailov',
                          :email => 'raphaleshamailove@gmail.com',
                          :password => ENV['DEFAULT_PASSWORD'],
                          :role => 'customer'
                       )
  end

  def charts # 2 charts
    labels = ['Standing Room', 'Seated Room']

    labels.size.times do |i|
      chart = @account.charts.new
      chart.background_image_url = '/images/jj-chart-bg.png'
      chart.label = labels[i]
      chart.save!
    end
  end
  
  def areas
    seating_chart_data = SVGParser.new('./public/svg/jjchart.svg')
        
    @account.charts.each do |chart|
      area_seats = seating_chart_data.area_seats
      single_seats = seating_chart_data.single_seats
      
      areas = []
    
      single_seats.each do |c|
        a = Area.new
        a.x = c[:x]
        a.y = c[:y]
        a.label_section = 'Table Seating'
        areas.push a
      end

      area_seats.each do |c|
        a = Area.new
        a.polypath = c[:poly]
        a.label_section = 'General Admission'
        areas.push a
      end
      
      chart.areas = areas
      chart.save!
    end

  end


  def tickets 
    @charts = @account.charts
    
    @account.events.each do |event|
    
      chart = (@charts.push @charts.shift)[0]

      chart.areas.each do |area|
        if area.type == :single
          t = @account.tickets.new :price => 15.00
          t.area = area
          t.state = 'open'
          event.tickets << t
        elsif area.type == :area
          50.times do
            t = @account.tickets.new :price => 10.00
            t.area = area
            t.state = 'open'
            event.tickets << t
          end
        end
      end
      
      
      
        
      
    end
  end


  def events
    events = xml_to_array(@events_url, 'event')
    
    account_charts = @account.charts.to_a
    
    events.each do |event|
      e = OpenStruct.new

      e.title = event['title']
      e.starts_at = Time.at event['event-date'].to_i
      e.body = event['event-descrip']
      e.price_freeform = event['price']
      e.set_times = event['set-times']
      e.info = event['additional-info']
      e.chart = account_charts.push account_charts.shift
      e.supporting_act_1 = event['supporting-act-1']
      e.supporting_act_2 = event['supporting-act-2']
      e.supporting_act_3 = event['supporting-act-3']

      e.artist_id_old = event['artist-id']

      puts "CREATING EVENT #{e.title}"

      @account.events.create!( e.marshal_dump )
    end
    
  end
  
  # Depends on events
  
  def artists
    @account.events.each do |event|
      artist_id = event.artist_id_old


      existing_artist = Artist.find_by_id_old(artist_id)
    
      if @existing_artist
        artist = existing_artist
      else
        artist = xml_to_array( @artist_url + '/' + artist_id.to_s, 'artist')[0]
        
        a = OpenStruct.new 
        
        a.name = artist['artist-name']
        a.body = artist['artist-descrip']
        a.myspace_url = artist['artist-myspace-url']
        a.url = artist['artist-url']
        a.facebook_url = artist['artist-facebook-url']
        a.audio_sample_url = artist['artist-audio-sample-url']
        # artist['artist-audio-sample-title']
        a.video_url = artist['artist-video-url']
        a.twitter = artist['twitter']
        a.youtube1 = artist['youtube1']
        a.youtube2 = artist['youtube2']
  
        img_url = artist['artist-image'].strip
        
        artist = @account.artists.new( a.marshal_dump )
        
        unless img_url.empty?
          file = open(img_url)
          filename = File.basename(img_url)
          artist.photo = file
          artist.photo.instance_write :file_name, filename
          puts "### Setting photo to #{img_url}"
        end
        artist.save!
      end
      
      event.headliner = artist
      event.save!
    end
  end

  # Depends on tickets
  def orders
    
    500.times do
      order = @account.orders.new
      order.user = User.with_role(:customer).first
      
      total_open_tickets = @account.tickets.with_state(:open).count
      
      num_tickets = rand(6) + 2 # between 2 and 8 tickets per this order
      
      num_tickets.times do 
        rand_ticket_offset = rand(total_open_tickets)
        rand_ticket_offset += 1 if total_open_tickets == 0
        ticket = @account.tickets.with_state(:open).offset( rand_ticket_offset ).limit(1).first()
        puts "### Adding ticket #{ticket.id} to new Order" 
        ticket.state = 'closed'

        order.tickets << ticket
        ticket.save!
      end
      
      order.status = 'paid'
      order.created_at = DateTime.now - rand(365) # random date in last year
      order.save!
    end
  end
  
  
  private
  
  def xml_to_array(url, element_name) # returns an array of hashes
    page = Nokogiri::XML(open(url))
    nodes = page.search("//#{element_name}").to_a.map{|node| node.children.inject({}){|a,c| a[c.name] = c.text if c.class == Nokogiri::XML::Element; a}}
    nodes
  end

end


