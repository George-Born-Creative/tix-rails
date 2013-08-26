# == Schema Information
#
# Table name: customer_imports
#
#  id                :integer          not null, primary key
#  account_id        :integer
#  state             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

require 'spec_helper'

describe CustomerImport do
  pending 'imports accepts a file, saves' do
    
    # file = File.new("spec/fixtures/customers.csv")
    # @customer_import = CustomerImport.new
    # @customer_import.data = file
    # @customer_import.save!
    # @customer_import.should be_valid
  end
    
end
