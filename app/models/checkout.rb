class Checkout
  include ActiveModel::Validations
  include ActiveModel::Naming
  
  
  attr_accessor :user_first_name, :user_last_name, :user_email,
                :card_number, :card_expiration, :card_cvv,
                :address_line_1, :address_line_2,
                :address_city, :address_state, :address_zip
  
  validates_presence_of :user_first_name, :user_last_name, :user_email
  
  validates_presence_of :card_number, :card_expiration, :card_cvv
  
  validates_presence_of :address_line_1, :address_city, :address_state, :address_zip
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end

end