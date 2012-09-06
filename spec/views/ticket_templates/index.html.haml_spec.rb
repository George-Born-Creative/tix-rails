require 'spec_helper'

describe "ticket_templates/index" do
  before(:each) do
    assign(:ticket_templates, [
      stub_model(TicketTemplate,
        :label => "Label",
        :file => "File",
        :meta => "Meta"
      ),
      stub_model(TicketTemplate,
        :label => "Label",
        :file => "File",
        :meta => "Meta"
      )
    ])
  end

  it "renders a list of ticket_templates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => "Meta".to_s, :count => 2
  end
end
