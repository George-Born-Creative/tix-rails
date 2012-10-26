# == Schema Information
#
# Table name: areas
#
#  id            :integer          not null, primary key
#  label         :string(255)
#  label_section :string(255)
#  polypath      :string(255)
#  x             :decimal(, )
#  y             :decimal(, )
#  stack_order   :integer          default(0)
#  chart_id      :integer
#  type          :string(255)
#  section_id    :integer
#  cx            :decimal(, )
#  cy            :decimal(, )
#  r             :decimal(, )
#  width         :decimal(, )
#  height        :decimal(, )
#  transform     :string(255)
#  points        :string(255)
#  max_tickets   :integer          default(1), not null
#  text          :string(255)
#

class Area < ActiveRecord::Base
  self.inheritance_column = :area_type
  
  attr_accessible :x, :y, :polypath, :label, :stack_order,
                  :cx, :cy, :r, :width, :height, :points, :transform,
                  :type, :max_tickets,
                  :reservations, :text
  
  belongs_to :section
  has_many :tickets  
  
  #alias_attribute :inventory, :max_tickets
  
  validates_inclusion_of :type, :in => %w( circle rect polygon text )
  # validates_presence_of :label
  
  
  def ticketable?
    self.inventory > 0
  end
  
  def inventory
    self.max_tickets - self.tickets.cart.count
  end

  
  private
  
  

    
end
