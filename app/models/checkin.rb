# == Schema Information
#
# Table name: checkins
#
#  id            :integer          not null, primary key
#  checked_in    :boolean
#  checked_in_at :datetime
#  ticket_id     :integer
#  status        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


class Checkin < ActiveRecord::Base
  
  attr_accessible :ticket_id, :status
  
  validates_presence_of :ticket_id
  validates_uniqueness_of :ticket_id
  
  
  

end
