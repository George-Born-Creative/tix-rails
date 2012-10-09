# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  caption           :string(255)
#  type              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  account_id        :integer
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end
