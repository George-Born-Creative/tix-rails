# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  phonable_id   :integer          not null
#  phonable_type :string(255)      not null
#  tag_for_phone :string(255)
#  number        :string(255)
#  country_code  :string(255)
#  locality_code :string(255)
#  local_number  :string(255)
#


# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  phonable_id   :integer          not null
#  phonable_type :string(255)      not null
#  tag_for_phone :string(255)
#  number        :string(255)
#  country_code  :string(255)
#  locality_code :string(255)
#  local_number  :string(255)
#
require 'phone'

class Phone < ActiveRecord::Base
  belongs_to :phonable, :polymorphic => true
  has_one :user, :as => :phonable
  
  attr_accessible :number, :country_code, :locality_code, :tag_for_phone, :local_number, :phonable_id, :phonable_type
end
