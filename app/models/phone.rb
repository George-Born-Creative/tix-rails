require 'phone'

class Phone < ActiveRecord::Base
  belongs_to :phonable, :polymorphic => true
  has_one :user, :as => :phonable
  
  attr_accessible :number, :country_code, :locality_code, :tag_for_phone, :local_number, :phonable_id, :phonable_type
end
