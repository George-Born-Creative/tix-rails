require 'spec_helper'

describe CustomerImportJob do
  
  before :each do 
    @customer_import = mock_model(CustomerImport)
    @customer_import.stub!(:id, 10)
    
  end

  
  it "enqueues" do
    Delayed::Job.count.should == 0
    # @customer_import.process!    
    # Delayed::Job.count.should == 1
  end
  
  describe 'states' do
   describe ':blank' do
     it 'should be in an initial state' do
       @customer_import.blank?.should be_true
     end
   end
 end

end