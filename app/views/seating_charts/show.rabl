object @seating_chart
attributes :id, :name
child( :single_seats) { attributes :id, :x, :y, :label }