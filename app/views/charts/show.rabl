object @seating_chart
attributes :id, :name
child( :single_seats) { attributes :id, :x, :y, :label, :default_price }
child( :area_seats) { attributes :id, :polypath, :label, :default_price }