# -*- encoding : utf-8 -*-
require 'json'
require './lib/svg_parser'
require 'date'



Event.delete_all
Artist.delete_all
Ticket.delete_all
Area.delete_all
Chart.delete_all
Order.delete_all
User.delete_all
Account.delete_all



# This document
# Account
# User
# Charts and Areas
# Events (Calls charts + counts)
#
#

#### 
#### Account
####
account = Account.create(:subdomain => 'jamminjava')
puts '### Creating account jamminjava'


#### 
#### User
####
shaun = account.users.create(  :first_name => 'Shaun',
                      :last_name => 'Robinson',
                      :email => 'shaun@squiid.com',
                      :password => ENV['DEFAULT_PASSWORD'],
                      :role => 'owner'
                   )
puts "### Creating user #{shaun.full_name}"


luke = account.users.create(  :first_name => 'Luke',
                      :last_name => 'Brindley',
                      :email => 'lukebrindley@me.com',
                      :password => ENV['DEFAULT_PASSWORD'],
                      :role => 'owner'
                   )
                   
puts "### Creating user #{luke.full_name}"
                   
daniel = account.users.create(  :first_name => 'Daniel',
                     :last_name => 'Brindley',
                     :email => 'daniel@goteammusic.com',
                     :password => ENV['DEFAULT_PASSWORD'],
                     :role => 'owner'
                  )

puts "### Creating user #{daniel.full_name}"

jonathan = account.users.create(  :first_name => 'Jonathan',
                      :last_name => 'Brindley',
                      :email => 'jonathanbrindley@gmail.com',
                      :password => ENV['DEFAULT_PASSWORD'],
                      :role => 'owner'
                   )


puts "### Creating user #{jonathan.full_name}"


#### 
#### Chart & Areas
####
def generate_chart(account)
  chart = account.charts.new
  chart.background_image_url = '/images/jj-chart-bg.png'

  seating_chart_data = SVGParser.new('./public/svg/jjchart.svg')
  area_seats = seating_chart_data.area_seats
  single_seats = seating_chart_data.single_seats

  single_seats.each do |c|
    a = Area.new
    a.x = c[:x]
    a.y = c[:y]
    a.label_section = 'Table Seating'
  
    chart.areas << a
  end

  area_seats.each do |c|
    a = Area.new
    a.polypath = c[:poly]
    a.label_section = 'General Admission'
    chart.areas << a
  end
  return chart
end # generate_chart

 
#### ###########
#### TICKETS ###
#### ###########
# Create one ticket for each single seat
# and 20 tickets for each area seat.
# Later this will be configurable by Area

def generate_tickets(eve, chart, account)
  eve.chart.areas.each do |area| 
    if area.type == :single
      t = account.tickets.new :price => 15.00
      t.area = area
      t.state = 'open'
      eve.tickets << t
    elsif area.type == :area
      50.times do
        t = account.tickets.new :price => 10.00
        t.area = area
        t.state = 'open'
        eve.tickets << t
      end
    end
  end
end



#### ###########
#### EVENTs and ARTISTS ###
#### ###########

require './lib/jj_website_parser'

def seed_events_and_artists(account)
  parser = JJWebsiteParser.new(account.subdomain)
  parser.process!
  parser.events.each do |eve|
    puts "### Generating chart for #{eve.title}..."
    eve.chart = generate_chart(account)
    puts "### Generating tickets for #{eve.title} ..."
  
    generate_tickets(eve, eve.chart, account)
    puts '### Saving...'
    eve.save!
    puts '### Done.'
  
  end
end

seed_events_and_artists(account)

#### ###########
#### ORDERS ###
#### ###########
NUM_ORDERS = 500

total_tickets = Ticket.count

NUM_ORDERS.times do
  order = account.orders.new
  num_tickets = rand(6) + 2 # 2 to 8 tickets in this order
  num_tickets.times do 
    rand_ticket_offset = rand(total_tickets)
    rand_ticket_offset += 1 if rand_ticket_offset == 0
    ticket = Ticket.offset( rand_ticket_offset ).limit(1).first()
    puts "### Adding ticket #{ticket.id} to Order #{order.id}" 
    ticket.state = 'closed'
    
    order.tickets << ticket
    ticket.save!
  end
  order.status = 'paid'
  order.save!
  
end