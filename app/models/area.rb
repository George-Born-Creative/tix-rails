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
#  height        :string(255)
#  decimal       :string(255)
#  transform     :string(255)
#  points        :string(255)
#

class Area < ActiveRecord::Base
  attr_accessible :x, :y, :polypath, :label, :stack_order,
                  :cx, :cy, :r, :width, :height, :points, :transform,
                  :type#, :fill
  
  belongs_to :section
  
  validates_inclusion_of :type, :in => %w( circle rect polygon text )
  
  # has_many :tickets
  
  # :single :area :invalid
  
  self.inheritance_column = :area_type

    
end
