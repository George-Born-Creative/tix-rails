# == Schema Information
#
# Table name: sidebars
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sidebar < ActiveRecord::Base
  attr_accessible :slug, :title, :widget_ids, :account
  belongs_to :account
  
  has_many :widget_placements,  :order => "index ASC"
  has_many :widgets, :through => :widget_placements
  
  has_many :pages

  accepts_nested_attributes_for :widgets
  
  validates_uniqueness_of :slug, :scope => :account_id
  
  
  def body(show_edit_controls = false)
    return ''# if self.widgets.count == 0
    # html = self.widget_placements.map do |widget_placement|
    #   widget = widget_placement.widget
    #   %Q{
    #      <div class="widget widget-slug-#{widget.slug unless widget.slug.blank?}">
    #        <!--div class="widget-title"><h3>#{widget.title unless widget.slug.blank?}</h3></div-->
    #        <div class="widget-body">#{widget.body unless widget.slug.blank?}</div>
    #     
    #      </div>
    #      <div class="clear"></div>
    #    }
    #   
    # end
    # html.join('').to_s.html_safe
  end
  
end
