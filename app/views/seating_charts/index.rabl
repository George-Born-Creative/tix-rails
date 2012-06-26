collection @seating_charts, :object_root => false
attributes :id, :name
child( :single_seats) { attributes :id, :x, :y, :label }