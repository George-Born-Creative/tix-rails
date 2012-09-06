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

require 'spec_helper'

describe Address do 
  
  it "should create" do
    @address = Address.new(  :tag_for_address => 'My Address',
                                        :country => 'USA',
                                        :address_line_1 => '123 Main St',
                                        :address_line_2 => 'Apt 3B',
                                        :locality => 'Derwood',
                                        :admin_area => 'MD',
                                        :postal_code => '22102',
                                        :addressable_id => 0,
                                        :addressable_type => 'User'
                                      )
                                      
    @address.save!.should eq true
    @address.should be_valid
    @address.address_line_1.should eq '123 Main St'
    @address.address_line_2.should eq 'Apt 3B'
  end
    
end
