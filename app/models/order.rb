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
  
  attr_accessible :total, :service_charge, :tax, :account, :user
  
  has_many :tickets
  belongs_to :user
  belongs_to :account
  
  validates_presence_of :user
  validates_presence_of :account

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
  
  

end
