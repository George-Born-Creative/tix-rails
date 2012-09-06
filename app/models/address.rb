# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  addressable_id   :integer          not null
#  addressable_type :string(255)      not null
#  tag_for_address  :string(255)
#  country          :string(255)
#  address_line_1   :string(255)
#  address_line_2   :string(255)
#  locality         :string(255)
#  admin_area       :string(255)
#  postal_code      :string(255)
#

class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
  has_one :user, :as => :addressable
  
  
  
  attr_accessible :tag_for_address, :country, 
                  :address_line_1, :address_line_2, 
                  :locality, :admin_area, :postal_code,
                  :addressable_id, :addressable_type,
                  :city, :state, :zip
              
  alias_attribute :city, :locality
  alias_attribute :state, :admin_area
  alias_attribute :zip, :postal_code

  def address
   "#{address_line_1} #{address_line_2}, #{locality}, #{admin_area}, #{country}"
  end
end


