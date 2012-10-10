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
  

  
  attr_accessible :total, :service_charge, :tax, :account, :user, :state
  
  has_many :tickets
  belongs_to :user
  belongs_to :account
  
  attr_accessor :cart, :expired, :paid, :ticketed
  attr_accessor :credit_card

  state_machine :state, :initial => :cart  do
    
    after_transition :on => :expire, :do => :release_tickets
    after_transition :on => :pay, :do => :process_payment
    before_transition :on => :email_tickets, :do => :generate_and_email_tickets
    
    
    event :expire do
      transition :cart => :expired
    end
    
    
    event :pay do
      transition :cart => :paid
      
      # validates_presence_of :user
      # validates_presence_of :account
    end
    
    event :email_tickets do
      transition :paid => :ticketed
    end
    
    
  end
  
  
  # def initialize
  #   super()
  # end
  
  def create_ticket(area_id)
    # TODO Watch out for race conditions here
    area = Area.find(area_id)
    if area.ticketable?
        area.update_attribute(:inventory, area.inventory - 1)
        self.tickets.create(:area => area)
        return true
    else
      return false
    end
  end

  def release_tickets
    puts "### Releasing tickets"
  end
  
  def process_payment
    puts "processing payment..."
    if false # payment successful
      self.fire_state_event(:email_tickets)
    else
      self.state = 'cart'
      return false
    end
  end
  
  def generate_and_email_tickets
    puts "### Gen/Emailing tickets"
  end
  
  
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
  
  
  def total_base_price
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.base_price}
  end
  
  def total_service_charge
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.service_charge}
  end
  
  def total
    self.tickets.reduce(0) {|memo, ticket| memo += ticket.total}
  end
  
  private
  
  # def calc_and_save_totals #before_savee
  #   return unless self.tickets
  #   total = 0.0
  #   total = self.tickets.reduce(0) do |memo, ticket|
  #     memo += ticket.price
  #   end
  #   self.total = total
  # end
  
  
  #  Credit Card format: {:number => number,
  #  :month => 3,        #for test cards, use any date in the future
  #  :year => 2013,
  #  :first_name => 'Mark',
  #  :last_name => 'McBride',
  #  :type => 'visa',       #note that MasterCard is 'master',
  #  :verification_value => '123'}
  

end
