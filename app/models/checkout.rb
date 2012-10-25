class Checkout
  include ActiveModel::Validations
  include ActiveModel::Naming
    
  attr_accessor :user_first_name, :user_last_name, :user_email,
                :card_number, :card_expiration, :card_cvv,
                :address_line_1, :address_line_2,
                :address_city, :address_state, :address_zip,
                :card_expiration,
                :card_expiration_month, :card_expiration_year
                
  attr_reader :card_type
  
  validates_presence_of :user_first_name, :user_last_name, :user_email
  
  validates_presence_of :card_number,  :card_cvv
  
  # validates_presence_of :card_expiration_month, :message => 'Card Expiration Month'
  # validates_presence_of :card_expiration_month, :message => 'Card Expiration Year'
  
  
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
  
  def process_order(order_id)
    order = Order.find(order_id)
    account = order.account
    user = account.users.find_or_initialize_by_email(self.user_email)
      
  end

  
  
  def card_expiration_month
    card_expiration.split('/')[0] if card_expiration
  end
  
  def card_expiration_year
    card_expiration.split('/')[0] if card_expiration
    
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
    #@credit_card ||=
    ActiveMerchant::Billing::CreditCard.new(
      :number             => card_number,
      :verification_value => card_cvv,
      :month              => card_expiration_month,
      :year               => card_expiration_year,
      :first_name         => user_first_name,
      :last_name          => user_last_name
    )
  end
  
  
  # require 'ostruct'
  # def card_expiration
  #   date = Date.civil(card_expiration[:"start_date(1i)"].to_i,card_expiration[:"start_date(2i)"].to_i)
  #   OpenStruct.new(:month => date.strftime("m").to_i, :year => date.strftime("%Y").to_i)
  # end
  

end