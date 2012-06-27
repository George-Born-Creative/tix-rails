require 'json'

SeatingChart.delete_all
SingleSeat.delete_all

chart = SeatingChart.new
chart.background_image_url = '/images/jj-chart-bg.png'
contents = File.read('./db/seed_data/seating_chart.json')
contents = JSON.parse contents

i=0

contents.each do |c|
  i+=1
  seat = SingleSeat.new
  seat.x = c['cx']
  seat.y = c['cy']
  seat.label = "Seat A#{i}"
  chart.single_seats << seat
end 
  

chart.save!
