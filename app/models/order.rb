class Order < ActiveRecord::Base
  has_many :tickets
  
  attr_accessible :ticket_ids_flat
  
  before_save :process_tickets
  
  def process_tickets
    ticket_ids_flat = self.ticket_ids_flat
    ticket_ids_flat = JSON.parse ticket_ids_flat
  end
  
end