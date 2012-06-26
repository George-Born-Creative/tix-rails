require 'json'

chart = SeatingChart.new

contents = File.read('./db/seed_data/seating_chart.json')
contents = JSON.parse contents

contents.each do |c|
  seat = SingleSeat.new
  seat.x = c['cx']
  seat.y = c['cy']
  chart.single_seats << seat
end

chart.save!
