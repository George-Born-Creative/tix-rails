# == Schema Information
#
# Table name: themes
#
#  id                            :integer          not null, primary key
#  title                         :string(255)
#  css_doc                       :text
#  activated_at                  :datetime
#  account_id                    :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  background_image_file_name    :string(255)
#  background_image_content_type :string(255)
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#

require 'spec_helper'

describe Theme do
  pending "add some examples to (or delete) #{__FILE__}"
end
