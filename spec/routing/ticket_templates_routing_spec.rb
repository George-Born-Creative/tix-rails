require "spec_helper"

describe TicketTemplatesController do
  describe "routing" do

    it "routes to #index" do
      get("/ticket_templates").should route_to("ticket_templates#index")
    end

    it "routes to #new" do
      get("/ticket_templates/new").should route_to("ticket_templates#new")
    end

    it "routes to #show" do
      get("/ticket_templates/1").should route_to("ticket_templates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ticket_templates/1/edit").should route_to("ticket_templates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ticket_templates").should route_to("ticket_templates#create")
    end

    it "routes to #update" do
      put("/ticket_templates/1").should route_to("ticket_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ticket_templates/1").should route_to("ticket_templates#destroy", :id => "1")
    end

  end
end
