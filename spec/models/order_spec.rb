# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  status                :string(255)      default("pending"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  account_id            :integer          default(0), not null
#  user_id               :integer
#  total                 :decimal(8, 2)    default(0.0), not null
#  tax                   :decimal(8, 2)    default(0.0), not null
#  service_charge        :decimal(8, 2)    default(0.0), not null
#  state                 :string(255)      default("cart")
#  expires_at            :datetime
#  card_type             :string(255)
#  card_expiration_month :string(255)
#  card_expiration_year  :string(255)
#  first_name            :string(255)
#  last_name             :string(255)
#  purchased_at          :datetime
#  email                 :string(255)
#  ip_address            :string(255)
#

require 'spec_helper'

describe Order do

  it 'should calculate total of tickets'
  it 'should accept cc'
  it 'should email tickets to usr upon completion'

end
