# == Schema Information
#
# Table name: widgets
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  account_id :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Widget do
  pending "add some examples to (or delete) #{__FILE__}"
end
