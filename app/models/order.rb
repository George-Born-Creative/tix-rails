# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  status         :string(255)      default("pending"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :integer          default(0), not null
#  user_id        :integer
#  total          :decimal(8, 2)    default(0.0), not null
#  tax            :decimal(8, 2)    default(0.0), not null
#  service_charge :decimal(8, 2)    default(0.0), not null
#



class Order < ActiveRecord::Base
  # before_save :calc_and_save_totals
  LIFESPAN = 10.minutes
  
  before_create :set_expires_at
  
  attr_accessible :total, :service_charge, :tax, :account, :user, :state, :expires_at
  
  has_many :tickets
  belongs_to :user
  belongs_to :account
  
  # attr_accessor :cart, :expired, :paid, :ticketed
  attr_accessor :credit_card

  attr_accessor :checkout # for a checkout object (non-persisted)
  
  scope :expired, lambda { where("expires_at < ?", Time.zone.now ) }
  scope :cart, lambda { where("expires_at >= ?", Time.zone.now ) }
  
  scope :with_role, lambda { |*roles| {
    :conditions => { :role => roles.map {|r| r.to_s}}
  }}
  
  # Used by Ajax Request
  def create_ticket(area_id)
    # TODO Watch out for race conditions here
    area = Area.find(area_id)
    if area.ticketable?
        self.tickets.create(:area => area)
        return true
    else
      return false
    end
  end

  
  def process_payment
    
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :number => @checkout.card_number,
      :month => @checkout.card_expiration_month,
      :year => @checkout.card_expiration_year,
      :first_name => @checkout.user_first_name,
      :last_name => @checkout.user_last_name
    )

    unless credit_card.valid?
      self.errors.add(:base, 'Card is invalid')
    else
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
         :login  => ENV['JJ_LOGIN_ID'],
         :password => ENV['TRANSACTION_KEY']
      )
      
      options = {:address => {}, :billing_address => {}}
      response = gateway.authorize(charge_amount, creditcard, options)
      
      if response.success?
        return true
      else
        self.errors.add(:base, 'Authorize failed')
      end
      
      # if response.success?
      #   gateway.capture(charge_amount, response.authorization)        
      # else
      #   puts "Fail: " + response.message.to_s
      #   self.errors.add(:base, 'Card is invalid')
      #   
      # end
      
    end
      
  end
  
  
  # Returns true if there are no errors and the checkout process completes
  #  :user_first_name => params[:user][:first_name],
  #  :user_last_name
  #  :user_email
  #  :card_number 
  #  :card_expiration_month 
  #  :card_expiration_year 
  #  :card_cvv => 
  #  :address_line_1
  #  :address_line_2 
  #  :address_city 
  #  :address_state 
  #  :address_zip  

  def process(checkout) # Checkout object
    @checkout = checkout
    return false unless checkout.valid?      
    return false unless self.process_payment
    
    self.update_attributes({
      :state => 'purchased'
    })
    
    session[:order_id] = nil
    true
  end
  
  def generate_and_email_tickets
    puts "### Gen/Emailing tickets"
  end
  
  
  def reserve(area_id)
    area = Area.find(area_id)
    if area.ticketable?
      self.tickets.create(:area => area)
      return true
    else
      return false
    end
  end
  
  
  
  #
  #
  # this order's TICKETS 
  #
  #
  
  
  
  def total_base_price
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.base_price}
  end
  
  def total_service_charge
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.service_charge}
  end
  
  def total
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.total_price}
  end
  
  def tickets_uniq_with_counts
    return nil if self.tickets.nil?
    self.tickets.reduce(Hash.new(0)){|h, t| h[t.area.section.label]+=1;h }
  end
  
  #
  #
  # CLASS methods for totals
  #
  #
  
  
  def self.total
    self.all.each.reduce(0) do |memo, order|
      memo += order.total 
    end
    #Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")
  end
  
  def self.total_tickets
    self.all.each.reduce(0) do |memo, order|
      memo += order.tickets.count
    end
  end
  
  def expired?
    self.expires_at < DateTime.now
  end
  
  
  private
  
  def set_expires_at
    self.expires_at = DateTime.now + LIFESPAN
  end

  

end
