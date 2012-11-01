class ResaveTicketsToStashEventId < ActiveRecord::Migration
  def up
    Ticket.all.each { |t| t.save! }
  end

  def down
  end
end
