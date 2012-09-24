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

require 'spec_helper'

describe Checkin do

  it "should mark ticket as closed"
  
end
