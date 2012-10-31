# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  status                :string(255)      default("pending"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  account_id            :integer          default(0), not null
#  user_id               :integer
#  total                 :decimal(8, 2)    default(0.0), not null
#  tax                   :decimal(8, 2)    default(0.0), not null
#  service_charge        :decimal(8, 2)    default(0.0), not null
#  state                 :string(255)      default("cart")
#  expires_at            :datetime
#  card_type             :string(255)
#  card_expiration_month :string(255)
#  card_expiration_year  :string(255)
#  first_name            :string(255)
#  last_name             :string(255)
#  purchased_at          :datetime
#  email                 :string(255)
#  ip_address            :string(255)
#  base                  :decimal(, )
#


class Order < ActiveRecord::Base
  # before_save :calc_and_save_totals
  LIFESPAN = 10.minutes
  
  before_create :set_expires_at
  before_save :cache_state
  before_save :set_totals
  
  attr_accessible :total, :service_charge, :tax, :base, :account, :user,  :expires_at,
                  :card_type, :card_expiration_month, :card_expiration_year, :first_name, :last_name,
                  :email, :address, :ip_address, :address_attributes
  
  attr_accessor :card_number, :card_verification, :card_expiration
  
  has_many :transactions, :class_name => "OrderTransaction", :order => 'created_at DESC'
  
  has_one :address, :as => :addressable, :dependent => :destroy
  has_one :phone, :as => :phonable, :dependent => :destroy
  
  accepts_nested_attributes_for :address
  
  has_many :tickets
  belongs_to :user
  belongs_to :account
  
  # attr_accessor :cart, :expired, :paid, :ticketed
  attr_accessor :credit_card

  attr_accessor :checkout # for a checkout object (non-persisted)
  
  # EXPIRED (dynamic: not complete && (Time.now + LIFESPAN) < expired_at   )
  scope :expired, lambda { where("expires_at < ? AND purchased_at IS ?", Time.zone.now, nil ) }
  # CART (dynamic: not expired, not purchased
  scope :cart, lambda { where("expires_at >= ? AND purchased_at IS ?", Time.zone.now, nil) }
  # COMPLETE (  purchased_at < Time.now   
  scope :complete, lambda { where("purchased_at < ?", Time.zone.now)}

  
  def expired?
    self.class.send('expired').exists?(self)
  end
  
  def cart?
    self.class.send('cart').exists?(self)
  end

  def complete?
    self.class.send('complete').exists?(self)
  end
  
  def cache_state
    self.state = 'expired' if self.expired?
    self.state = 'cart' if self.cart?
    self.state = 'complete' if self.complete?
  end
  
  # Used by Ajax Request
  def create_ticket(area_id)
    # TODO Watch out for race conditions here
    area = Area.find(area_id)
    if area.ticketable?
      self.tickets.create(:area => area)
      # If this is the first ticket, reset order expiration
      set_expires_at() if self.tickets.count == 1
      
      return true
    else
      return false
    end
  end

  
  def purchase
    # raise credit_card.to_s
    puts "price_in_cents #{price_in_cents}"
    puts "credit_card #{credit_card}"
    puts "credit_card #{credit_card.valid?}"
    puts "purchase_options #{purchase_options.to_s}"
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    if response.success?
      update_attribute(:purchased_at, Time.now) 
      self.save # to trigger before_saves (cache_state)
      TicketMailer.delay.send_tickets(self.account.id, self.id, true) # true=send_tickets
    end
    response.success?
  end
  
 

  def price_in_cents
    (total*100).round
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
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  #
  #
  # this order's TICKETS 
  #
  #
  
  
  
  def total_base_price
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.base_price || 0}
  end
  
  def total_service_charge
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.service_charge || 0}
  end
  
  def total
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.total || 0}
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
  
  def self.total_for_day # Date
    self.complete.where('purchased_at BETWEEN ? AND ?', Time.zone.today.to_date, Time.zone.today.to_date+1)
        .sum('service_charge')
  end
  
  private
  
  
  def set_expires_at
    self.expires_at = DateTime.now + LIFESPAN
  end


  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

  def credit_card
   @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
     :type               => card_type,
     :number             => card_number,
     :verification_value => card_verification,
     :month              => card_expiration_month,
     :year               => card_expiration_year,
     :first_name         => first_name,
     :last_name          => last_name
   )
  end
  
  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "#{first_name} #{last_name}",
        :address1 => address.address_line_1,
        :city     => address.city,
        :state    => address.state,
        :country  => "US",
        :zip      => address.zip
      }
    }
  end
  
  def set_totals
    self.service_charge = self.tickets.sum('service_charge')
    self.base = self.tickets.sum('base_price')
    self.total = self.service_charge + self.base
  end

  # Test Cards for Authorize.net∂
  #
  # American Express Test Card: 370000000000002
  # Discover Test Card: 6011000000000012
  # Visa Test Card: 4007000000027
  # Second Visa Test Card: 4012888818888
  # JCB: 3088000000000017
  # Diners Club/ Carte Blanche: 38000000000006
  

end
