# == Schema Information
#
# Table name: orders
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  account_id              :integer          not null
#  user_id                 :integer
#  total                   :decimal(8, 2)    default(0.0), not null
#  tax                     :decimal(8, 2)    default(0.0), not null
#  service_charge          :decimal(8, 2)    default(0.0), not null
#  state                   :string(255)
#  expires_at              :datetime
#  card_type               :string(255)
#  card_expiration_month   :string(255)
#  card_expiration_year    :string(255)
#  first_name              :string(255)
#  last_name               :string(255)
#  purchased_at            :datetime
#  email                   :string(255)
#  ip_address              :string(255)
#  base                    :decimal(, )
#  agent_id                :integer
#  payment_method_name     :string(255)
#  payment_origin_name     :string(255)
#  deliver_tickets         :boolean
#  checkin_tickets         :boolean
#  service_charge_override :decimal(, )
#  agent_checkout          :boolean
#  tickets_delivered_at    :datetime
#


class Order < ActiveRecord::Base
  LIFESPAN = 10.minutes
  
  after_create :set_expires_at!
  after_initialize :set_defaults
  
  attr_accessible :total, :service_charge, :tax, :base, :account, :user, :agent, :expires_at,
                  :card_type, :card_expiration_month, :card_expiration_year, :first_name, :last_name,
                  :email, :address, :ip_address, :address_attributes, :phone, :phone_attributes,
                  :payment_method_name, :payment_origin_name, :deliver_tickets,
                  :checkin_tickets, :agent_checkout, :tickets_delivered_at,
                  :service_charge_override, :card_verification,
                  :card_number, :card_purchase
                  
  attr_accessor :card_number, :card_verification, :credit_card,
                :card_purchase, 
                :checking_out, :notify_agents,
                :card_expiration_date
  
  has_many :tickets, :inverse_of => :order
  has_many :events, :through => :tickets, :uniq => true
  
  belongs_to :user
  belongs_to :agent, :class_name => "User"
  belongs_to :account
  has_many :transactions, :class_name => "OrderTransaction", :order => 'created_at DESC', :dependent => :destroy
  has_one :address, :as => :addressable, :dependent => :destroy
  has_one :phone, :as => :phonable, :dependent => :destroy
  
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phone
    
  def card_purchase?; self.card_purchase; end  
  def deliver_tickets?; deliver_tickets; end  
  def checkin_tickets?; checkin_tickets; end  
  def agent_checkout?; @agent_checkout; end
  
  state_machine :initial => :cart do
    
    # around_transition do |order, transition, block|
    #   puts   ''
    #   puts   '#######'
    #   puts   " ####### START from #{transition.from} to #{transition.to}"
    # 
    #   block.call
    #   puts   " ####### END from #{transition.from} to #{transition.to}"
    #   puts   ''
    # end
      
    
      
    before_transition [:err, :cart, :processing] => :processing, :do => :update_totals!
    before_transition [:err, :cart, :processing] => :processing, :do => :update!
    after_transition [:err, :cart, :processing] => :processing, :do => :purchase_with_card!, :if => :card_purchase?
    after_transition [:err, :cart, :processing] => :processing, :do => :purchase_without_card!, :unless => :card_purchase?
     
    before_transition :processing => :complete do |order|
      # # puts   "START BEFORE PROCESSING > COMPLETE"
      order.update_attribute :purchased_at, Time.zone.now
      order.update!
      order.update_totals!
      order.update_service_charges!
      # # puts   "END BEFORE PROCESSING > COMPLETE"
    end
    
    after_transition :processing => :complete do |order|
      # # puts   "START AFTER PROCESSING > COMPLETE"
      
      # # puts   order.checkin_tickets?
      
      order.deliver_tickets! if order.deliver_tickets?
      order.checkin_tickets! if order.checkin_tickets?
      order.notify_agents!
      # # puts   "END AFTER PROCESSING > COMPLETE"
      
    end
                 
    event :purchase do 
      transition [:cart, :err, :processing] => :processing
    end 

    event :err do
      transition [:processing] => :err
    end
    
    event :finalize do
      transition [:processing] => :complete
    end

    state :processing do
      validates :payment_method_name, :presence => true, :unless => :card_purchase?
      validates :agent, :presence => true, :if => proc{ |obj| obj.user.nil? }
      validates :user, :presence => true, :if => proc{ |obj| obj.agent.nil? }
      validates :first_name, :last_name, :email, :presence => true, :if => :deliver_tickets?
      
      validates :first_name, :last_name, :email, 
                :address, :phone, 
                :card_number, :card_verification, 
                :card_expiration_month, :card_expiration_year,
                :presence => true, :if => :card_purchase?
    end

  end
  
  def update_service_charges!
    # puts   "updating service charge for all tickets"
    tickets.each { |t| t.update_attribute(:service_charge_override, self.service_charge_override) }
  end
  
  def set_defaults
    @card_purchase = false if @card_purchase.nil?
    self.deliver_tickets = false if self.attributes.keys.include?(:deliver_tickets) && self.deliver_tickets.nil?
    @checkin_tickets = false if @checkin_tickets.nil?
    @notify_agents = true if @notify_agents.nil?
  end
  
  def has_user?; !self.user.nil?; end
  def has_agent?; !self.agent.nil?; end
  
  def update!
    save!
  end
  
  def notify_agents!
    # # puts   'Order.notify_agents! called'
  end
  
  def update_totals!
    # # puts   "update_totals!"
    _base = self.tickets.map(&:base_price).sum
    _service = self.tickets.map(&:service_charge).sum
    
    
    update_attribute(:base, total_base_price)
    update_attribute(:service_charge, total_service_charge)
    update_attribute(:total, total_total)
    
    # self.base = total_base_price
    # self.service_charge = total_service_charge
    # self.total = total_total
    
    update_ticket_service_charges!
  end
  
  scope :expired, lambda { where("expires_at < ? AND purchased_at IS ?", Time.zone.now, nil ) }
  # scope :cart, lambda { where("expires_at >= ? AND purchased_at IS ?", Time.zone.now, nil) }
  scope :complete, lambda { where("purchased_at < ?", Time.zone.now) }
  scope :purchased_between, lambda { |start_time, end_time| where(:purchased_at => (start_time...end_time)) }
  
  # def purchase!
  #   return false unless self.valid?
  #   card_purchase? ? purchase_with_card! : purchase_without_card! 
  # end
  
  def purchase_with_card!
    puts  'purchase_with_card!'
    unless validate_card 
      puts 'card invalid'
      puts 'calling err'
      err!
      puts 'state'
      puts self.state
      puts 'saving...'
      self.save!
      puts 'saved. state is'
      puts self.state
      puts 'valid?'
      puts self.valid?
      puts self.errors.full_messages
      return false 
    end
  
    mode = self.account.gateway.mode
    gateway = self.account.gateway.authorize_net
    
    response = gateway.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", 
                         :amount => price_in_cents, 
                         :response => response,
                         :meth => 'card',
                         :origin => 'web',
                         :gateway_mode => mode)
    
    puts "RESPONSE.success?"
    puts response.success?
               
    if response.success?
      puts "calling FINALIZE"
      finalize!
      puts "STATE"
      puts state
    else
      puts  "calling ERR!"
      err!
      puts 'STATE:'
      puts state
    end
    
    # response.success?
  end
  
  def purchase_without_card!
    # # puts   "## PURCHASE without card in amount:"
    # # puts   price_in_cents
    transactions.create!(:action => "purchase", 
                        :amount => price_in_cents, 
                        :success => true, 
                        :meth => payment_method_name,
                        :origin => payment_origin_name)
    finalize!
    
    true # success
  end
  
  def expired?
    self.class.send('expired').exists?(self)
  end
  
  def cart?
    self.class.send('cart').exists?(self)
  end
  
  def complete?
    self.class.send('complete').exists?(self)
  end
  
  # Used by Ajax Request
  def create_ticket(area_id)
    # TODO Watch out for race conditions here
    area = Area.find(area_id)
    if area.ticketable?
      ticket = self.tickets.create(:area => area)
      # Renew order expiration as new tickets are added
      set_expires_at!
      return true
    else
      return false
    end
  end
  
  def checkin_tickets!
    # # puts   'Order.checkin_tickets! called' 
    self.tickets.each{ |t| t.checkin! } # causing stack overflow / segmentation fault
    # self.tickets.each{ |t| t.update_column(:checked_in_at, Time.zone.now) }
  end
  
  def update_ticket_service_charges!
    # # puts   'update_ticket_service_charges! called' 
    unless self.service_charge_override.nil?
      self.tickets.each{ |t| t.update_attribute(:service_charge_override, self.service_charge_override) }
    end
  end
  
  def all_tickets_checked_in?
    self.tickets.each{ |t| return false unless t.checked_in? }
    true
  end

  # Convienience method for getting order expiration in seconds
  # A negative value means order has expired
  
  def expires_in_seconds
    '%.0f' % ( expires_at - Time.now )
  end
  
  def deliver_tickets!
    # # puts   'Order.deliver_tickets! called' 
    TicketMailer.delay.send_tickets(self.account.id, self.id)
  end

  def price_in_cents
    (total_total*100).round
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # calculated columns -- stored in DB in #update_totals! as total, service_charge, total

  def total_base_price
    tickets.map(&:base_price).sum
  end
  
  def total_service_charge
    tickets.map(&:service_charge).sum
  end
  
  def total_total
    total_base_price + total_service_charge
  end
  
  def events_uniq_with_counts # returns has of event name => qty
    return nil if self.tickets.nil?
    self.tickets.reduce(Hash.new(0)){|h, t| h[t.event.name]+=1;h }
  end  
  
  # Class methods
  
  def self.payment_method_totals
    complete
    .except(:order)
    .select('payment_method_name, sum(total) as total')
    .group('payment_method_name')
  end
  
  def self.payment_origin_totals
    complete
    .except(:order)
    .select('payment_origin_name, sum(total) as total')
    .group('payment_origin_name')
  end
  
  def self.agent_totals
    complete
    .except(:order)
    .select('orders.agent_id, users.first_name, users.last_name, users.id, sum(orders.total) as total')
    .joins('INNER JOIN users ON users.id = orders.agent_id')
    .group('orders.agent_id, users.first_name, users.id')
    
  end
  
  def self.total
    sum('total')
  end
  
  def self.total_tickets
    self.all.each.reduce(0) do |memo, order|
      memo += order.tickets.count
    end
  end
  
  def self.purchased_today
    today = Time.zone.now
    purchased_on_date(today)
  end
  
  def self.purchased_yesterday
    yesterday = Time.zone.now - 1.day
    purchased_on_date(yesterday)
  end
  
  def self.purchased_on_date(date) # e.g. 2012-10-15 for Oct 15th

    unless date.class == ActiveSupport::TimeWithZone
      date = DateTime.strptime(date, "%Y-%m-%d").to_date
    end
    
    purchased_between(date.beginning_of_day, date.end_of_day).order('purchased_at desc')
  end
  
  def self.purchased_this_week
    start_time = (Time.zone.now - 1.week).beginning_of_day
    end_time = Time.zone.now
    purchased_between(start_time, end_time)
  end
  
  def self.uniq_event_sales # returns hash of titles by array
    # TODO Write an ActiveRecord or Arel query for this
    h = {}
    self.scoped.each do |order| 
      order.tickets.each do |t|
        h[t.event.title] = {:id => nil, :count => 0, :base => 0.0, :service => 0.0, :total => 0.0 } if h[t.event.title].blank?
        
        h[t.event.title][:id] = t.event.id if h[t.event.title][:id].blank?
        h[t.event.title][:count] += 1
        h[t.event.title][:base] += t.base_price
        h[t.event.title][:service] += t.service_charge
        h[t.event.title][:total] += t.total
        
      end
    end
    h
  end
  
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand               => 'bogus',
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expiration_month,
      :year               => card_expiration_year,
      :first_name         => first_name,
      :last_name          => last_name
    )
   end
   
   
  def self.with_state(state)
    scoped.where('state = ?', state)
  end
  
  def reset_expires_at!
    set_expires_at!
  end
  
  private
  
  def set_expires_at!
    self.update_attribute(:expires_at, DateTime.now + LIFESPAN)
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
       :zip      => address.zip,
     }
   }
  end

  def validate_card
   unless credit_card.valid?
     puts  "validate_card: card messages"
     
     credit_card.errors.full_messages.each do |message|
       # TODO figure out how to push these onto the Order error object
       # Currently pulling them in directly in Front::OrderController

       self.errors[:base] << message
       self.errors.add(:base,  message)
     end
     return false
   end
   true
  end
  
   

  #
  # Test Cards for Authorize.net
  #
  # American Express Test Card: 370000000000002
  # Discover Test Card: 6011000000000012
  # Visa Test Card: 4007000000027
  # Second Visa Test Card: 4012888818888
  # JCB: 3088000000000017
  # Diners Club/ Carte Blanche: 38000000000006
  #
end
