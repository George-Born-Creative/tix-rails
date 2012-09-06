require 'spec_helper'

describe "ticket_templates/show" do
  before(:each) do
    @ticket_template = assign(:ticket_template, stub_model(TicketTemplate,
      :label => "Label",
      :file => "File",
      :meta => "Meta"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
    rendered.should match(/File/)
    rendered.should match(/Meta/)
  end
end
