# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  price          :decimal(, )
#  state          :string(255)      default("open"), not null
#  event_id       :integer
#  area_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :integer
#  account_id     :integer          default(0), not null
#  base_price     :decimal(, )
#  service_charge :decimal(, )
#  area_label     :string(255)
#  section_label  :string(255)
#

class Ticket < ActiveRecord::Base
  
  TICKET_TIME_OUT = 5.minutes
  
  belongs_to :event
  belongs_to :area
  
  belongs_to :order
  belongs_to :account
  
  attr_accessor :status
  
  attr_accessible :event_id,
                  :area_id,
                  :seat_name,
                  :section_name,
                  :base_price,
                  :service_charge,
                  :status,
                  :area_label,
                  :section_label
  
  
  state_machine :initial => :open do
    state :open do
      # created_at
    
    end
    
    state :locked do
      # locked_at
      # locked_by
      
    end
  
    state :purchased do
      # locked_at
      # locked_by
    end
    
    state :checked_in do
      
    end
    
    event :lock do
      
    end
  end
  
  def initialize
     @seatbelt_on = false
     @time_used = 0
     @auto_shop_busy = true
     super() # NOTE: This *must* be called, otherwise states won't get initialized
   end
  
  
  def total_price
    self.base_price + self.service_charge
  end
  
  def lock(user_id)
    
  end
  
  
end
