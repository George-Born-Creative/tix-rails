require 'spec_helper'

describe "sidebars/edit" do
  before(:each) do
    @sidebar = assign(:sidebar, stub_model(Sidebar))
  end

  it "renders the edit sidebar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sidebars_path(@sidebar), :method => "post" do
    end
  end
end
