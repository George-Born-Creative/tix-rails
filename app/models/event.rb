class Event < ActiveRecord::Base
  attr_accessible :title, :starts_at
  attr_accessible :date, :price_freeform, :set_times, :info, :headliner, :body,
                  :suggestion_1, :suggestion_2, :suggestion_3,
                  :supporting_act_1, :supporting_act_2, :supporting_act_3
                  
                  
  # attr_accessible :ends_at, :headline, :body, :image_uri, :image_thumb_uri
  
  attr_accessor :starts_at_formatted 
  
  belongs_to :chart
  has_many :tickets
  
  belongs_to :account
  belongs_to :headliner, :class_name => 'Artist'
  belongs_to :second_headliner, :class_name => 'Artist'
  
  # belongs_to :supporting_act_1, :class_name => 'Artist'
  # belongs_to :supporting_act_2, :class_name => 'Artist'
  # belongs_to :supporting_act_3, :class_name => 'Artist'
  
  # belongs_to :suggestion_1, :class_name => 'Event'
  # belongs_to :suggestion_2, :class_name => 'Event'
  # belongs_to :suggestion_3, :class_name => 'Event'
  
  
  def starts_at_formatted
    self.starts_at.to_formatted_s(:jammin_java)
  end
end


    
