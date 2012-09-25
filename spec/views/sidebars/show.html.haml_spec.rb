require 'spec_helper'

describe "sidebars/show" do
  before(:each) do
    @sidebar = assign(:sidebar, stub_model(Sidebar))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
