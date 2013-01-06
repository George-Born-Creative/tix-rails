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

  before_save :touch_sidebars
  
  attr_accessible :body, :slug, :title, :account_id, :sidebar_ids
  
  validates_presence_of :title
  # validates_uniqueness_of :slug, :scope => :account_id
  
  accepts_nested_attributes_for :sidebars
  
  
  private
  
  def touch_sidebars
    return true if sidebars.empty?
    sidebars.each do |sidebar|
      sidebar.touch
    end
    true
  end
  
  
end
