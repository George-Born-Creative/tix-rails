class Widget < ActiveRecord::Base
  
  has_many :widget_placements
  has_many :sidebars, :through => :widget_placements
  belongs_to :account
  
  attr_accessible :body, :slug, :title, :account_id, :sidebar_ids
  
  validates_presence_of :title
  #validates_uniqueness_of :slug, :scope => :account_id
  
  accepts_nested_attributes_for :sidebars
  
  #  Accepts params[:sidebar_ids]  (e.g. from checkboxes)
  # "sidebar_ids"=>["1", "2", ""]}, 
  # def update_sidebars(sidebar_id_params)
  #   Sidebar.each     
  #     sidebar_id_params.each do |sidebar_id|
  #       self.sidebars << Sidebar.find(sidebar_id)
  #     end
  #   end
  # end
  
  
end
