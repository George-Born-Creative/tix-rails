# == Schema Information
#
# Table name: widget_placements
#
#  id         :integer          not null, primary key
#  sidebar_id :integer
#  widget_id  :integer
#  account_id :integer
#  index      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe WidgetPlacement do
  pending "add some examples to (or delete) #{__FILE__}"
end
