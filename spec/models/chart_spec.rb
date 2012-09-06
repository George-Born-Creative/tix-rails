# == Schema Information
#
# Table name: charts
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  background_image_url   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :integer          default(0), not null
#  label                  :string(255)
#  svg_file_file_name     :string(255)
#  svg_file_content_type  :string(255)
#  svg_file_file_size     :integer
#  svg_file_updated_at    :datetime
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#  svg_file_serialized    :text
#


require 'spec_helper'

describe Chart do

  it "should Marshal to/from JSON"
  
end
