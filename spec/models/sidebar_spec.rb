# == Schema Information
#
# Table name: sidebars
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Sidebar do
  pending "add some examples to (or delete) #{__FILE__}"
end
