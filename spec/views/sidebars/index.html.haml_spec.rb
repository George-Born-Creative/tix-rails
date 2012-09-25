require 'spec_helper'

describe "sidebars/index" do
  before(:each) do
    assign(:sidebars, [
      stub_model(Sidebar),
      stub_model(Sidebar)
    ])
  end

  it "renders a list of sidebars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
