require 'spec_helper'
require './app/lib/tix'

describe Tix::CSVImporter do
  
  it "should create model given csv and class" do
    user = mock_model("Model")
    user.stub!(:create).and_return(true)
    @importer = Tix::CSVImporter.new('./db/fixtures/jamminjava/customers-mini.csv', user)
  end
  
end
