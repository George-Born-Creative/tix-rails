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


#### 
#### Chart & Areas
####
def generate_chart
  chart = Chart.new
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

def generate_tickets(eve, chart)
  eve.chart.areas.each do |area| 
    if area.type == :single
      t = Ticket.new :price => 15.00
      t.area = area
      t.state = 'open'# ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
      eve.tickets << t
    elsif area.type == :area
      50.times do
        t = Ticket.new :price => 10.00
        t.area = area
        t.state = 'open'# ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
        eve.tickets << t
      end
    end
  end
end



#### ###########
#### EVENTs and ARTISTS ###
#### ###########

require './lib/jj_website_parser'

def seed_events_and_artists()
  parser = JJWebsiteParser.new
  parser.process!
  parser.events.each do |eve|
    puts "### Generating chart for #{eve.title}..."
    eve.chart = generate_chart
    puts "### Generating tickets for #{eve.title} ..."
  
    generate_tickets(eve, eve.chart)
    puts '### Saving...'
    eve.save!
    puts '### Done.'
  
  end
end

seed_events_and_artists

#### ###########
#### ORDERS ###
#### ###########
NUM_ORDERS = 500

total_tickets = Ticket.count

NUM_ORDERS.times do
  order = Order.new
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