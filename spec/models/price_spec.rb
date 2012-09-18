# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  label      :string(255)
#  base       :decimal(8, 2)    default(0.0), not null
#  service    :decimal(8, 2)    default(0.0), not null
#  tax        :decimal(8, 2)    default(0.0), not null
#  account_id :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Price do
  pending "add some examples to (or delete) #{__FILE__}"
end
