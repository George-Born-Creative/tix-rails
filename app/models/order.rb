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
  
  attr_accessor :cart, :expired, :paid, :ticketed
  attr_accessor :credit_card

  
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
  
  
  def reserve(area_id)
    area = Area.find(area_id)
    if area.ticketable?
      self.tickets.create(:area => area)
      return true
    else
      return false
    end
  end
  
  
  
  
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
  
  
  # Class methods for totals
  
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
