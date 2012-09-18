object @chart
attributes :id, :name, :background_color
  
child (:sections) do
  attributes :id, :label, :seatable, :color

  child :presale_price => :presale_price do
    attributes :id, :base, :service, :tax, :total
  end
  
  child :dayof_price => :dayof_price do
    attributes :id, :base, :service, :tax, :total
  end
  
  child(:areas) do
    attributes :id, :type, :x, :y, :polypath, :label, :stack_order,
    :cx, :cy, :r, :width, :height, :points, :transform,
    :max_tickets, :label

  end
end





# Table name: charts
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  background_image_url   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :integer          default(0), not null
#  label                  :string(255)
#  svg_file_file_name     :string(255)
#  svg_file_content_type  :string(255)
#  svg_file_file_size     :integer
#  svg_file_updated_at    :datetime
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#  svg_file_serialized    :text
#


# attributes :id, :body, :title, :headline, :supporting_act,  :image_uri, :image_thumb_uri, :starts_at, :ends_at


# child( :tickets) { attributes :id, :area_id, :event_id, :state, :label }
# child( :chart) do
#   attributes :id, :background_image_url
#   child( :areas) { attributes :id, :x, :y, :type, :polypath, :label, :label_section }  
# end