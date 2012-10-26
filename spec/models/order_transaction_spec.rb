# == Schema Information
#
# Table name: order_transactions
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  action        :string(255)
#  amount        :integer
#  success       :boolean
#  authorization :string(255)
#  message       :string(255)
#  params        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe OrderTransaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
