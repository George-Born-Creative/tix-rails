class WidgetPlacement < ActiveRecord::Base
  # Places Widgets in Sidebars, storing Index
  attr_accessible :index, :sidebar_id, :widget_id
  
  belongs_to :account
  belongs_to :widget
  belongs_to :sidebar
  
  
end
