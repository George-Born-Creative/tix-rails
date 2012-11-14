# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  slug       :string(255)      not null
#  title      :string(255)      not null
#  body       :text
#  account_id :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sidebar_id :decimal(, )
#

class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title, :sidebar_id
    
  belongs_to :account
  belongs_to :parent, :class_name => 'Page'
  belongs_to :sidebar
  has_many :children, :class_name => 'Page', :foreign_key => 'parent_id'
  
  validates_uniqueness_of :slug, :scope => :account_id

  def self.by_id_or_slug(slug_or_id, account_id)
    @page = Page.where('account_id = ? AND (slug = ? OR id = ?)', account_id, slug_or_id, slug_or_id).first
  end
  
  
end
