require 'spec_helper'

describe CustomerImportJob do
  
  before :each do 
    @customer_import = mock_model(CustomerImport)
    @customer_import.stub!(:id, 10)
  end


end