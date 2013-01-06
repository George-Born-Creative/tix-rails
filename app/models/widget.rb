# == Schema Information
#
# Table name: widgets
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  account_id :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Widget < ActiveRecord::Base
  
  has_many :widget_placements, :dependent => :destroy
  has_many :sidebars, :through => :widget_placements
  belongs_to :account
  
  attr_accessible :body, :slug, :title, :account_id, :sidebar_ids
  
  validates_presence_of :title
  # validates_uniqueness_of :slug, :scope => :account_id
  
  accepts_nested_attributes_for :sidebars
  
  
  
end
