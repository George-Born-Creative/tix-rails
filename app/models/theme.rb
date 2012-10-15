class Theme < ActiveRecord::Base
  attr_accessible :activated_at, :css_doc, :title
  has_paper_trail
  
  def activate!
    self.activated_at = DateTime.now
  end
  
end
