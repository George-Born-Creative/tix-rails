require 'spec_helper'

describe "ticket_templates/new" do
  before(:each) do
    assign(:ticket_template, stub_model(TicketTemplate,
      :label => "MyString",
      :file => "MyString",
      :meta => "MyString"
    ).as_new_record)
  end

  it "renders new ticket_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_templates_path, :method => "post" do
      assert_select "input#ticket_template_label", :name => "ticket_template[label]"
      assert_select "input#ticket_template_file", :name => "ticket_template[file]"
      assert_select "input#ticket_template_meta", :name => "ticket_template[meta]"
    end
  end
end
