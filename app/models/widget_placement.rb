# == Schema Information
#
# Table name: widget_placements
#
#  id         :integer          not null, primary key
#  sidebar_id :integer
#  widget_id  :integer
#  account_id :integer
#  index      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WidgetPlacement < ActiveRecord::Base
  # Places Widgets in Sidebars, storing Index
  attr_accessible :index, :sidebar_id, :widget_id
  
  belongs_to :account
  belongs_to :widget
  belongs_to :sidebar
  
  alias_attribute :position, :index
  
end
