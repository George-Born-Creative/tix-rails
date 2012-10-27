# == Schema Information
#
# Table name: carousel_items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  caption     :string(255)
#  link        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  expires_at  :datetime
#  index       :integer
#  carousel_id :integer
#

require 'spec_helper'

describe CarouselItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
