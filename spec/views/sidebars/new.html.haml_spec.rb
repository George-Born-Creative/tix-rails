require 'spec_helper'

describe "sidebars/new" do
  before(:each) do
    assign(:sidebar, stub_model(Sidebar).as_new_record)
  end

  it "renders new sidebar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sidebars_path, :method => "post" do
    end
  end
end
