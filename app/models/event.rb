# == Schema Information
#
# Table name: events
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  headline               :string(255)
#  supporting_act         :text
#  body                   :text
#  starts_at              :datetime
#  ends_at                :datetime
#  chart_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  headliner_id           :integer
#  secondary_headliner_id :integer
#  supporting_act_1       :string(255)
#  supporting_act_2       :string(255)
#  supporting_act_3       :string(255)
#  info                   :text
#  set_times              :text
#  price_freeform         :string(255)
#  account_id             :integer          default(0), not null
#  chart                  :string(255)
#  artist_id_old          :integer
#  cat                    :string(255)
#


class Event < ActiveRecord::Base
  attr_accessible :title, :starts_at
  attr_accessible :date, :price_freeform, :set_times, :info, :headliner, :body,
                  :suggestion_1, :suggestion_2, :suggestion_3,
                  :supporting_act_1, :supporting_act_2, :supporting_act_3,
                  :artist_id_old, :chart, :tickets, :starts_at, :secondary_headliner_id,
                  :cat # TODO move category into its own model
    
  
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


  
end


    
