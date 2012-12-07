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

require 'spec_helper'

describe Order do

  it 'should calculate total of tickets'
  it 'should accept cc'
  it 'should email tickets to usr upon completion'

end
