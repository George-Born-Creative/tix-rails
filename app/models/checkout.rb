class Checkout
  include ActiveModel::Validations
  include ActiveModel::Naming
    
  attr_accessor :user_first_name, :user_last_name, :user_email,
                :card_number, :card_cvv,
                :address_line_1, :address_line_2,
                :address_city, :address_state, :address_zip,
                :card_expiration_month, :card_expiration_year,
                :phone_number
                
  attr_reader :card_type
  
  # validates_presence_of :user_first_name, :user_last_name, :user_email
  
  validates_presence_of :card_number,  :card_cvv
  
  validates_presence_of :card_expiration_month, :message => 'Card Expiration Month'
  validates_presence_of :card_expiration_year, :message => 'Card Expiration Year'
  
  validates_presence_of :address_line_1, :address_city, :address_state, :address_zip
  
  validate :validate_card#, :on => :create
  
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  private
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add(:card_expiration, message)
      end
    end
  end
  
  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      :number             => card_number,
      :verification_value => card_cvv,
      :month              => card_expiration_month,
      :year               => card_expiration_year,
      :first_name         => user_first_name,
      :last_name          => user_last_name
    )
  end
  
  

end