require "spec_helper"

describe SidebarsController do
  describe "routing" do

    it "routes to #index" do
      get("/sidebars").should route_to("sidebars#index")
    end

    it "routes to #new" do
      get("/sidebars/new").should route_to("sidebars#new")
    end

    it "routes to #show" do
      get("/sidebars/1").should route_to("sidebars#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sidebars/1/edit").should route_to("sidebars#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sidebars").should route_to("sidebars#create")
    end

    it "routes to #update" do
      put("/sidebars/1").should route_to("sidebars#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sidebars/1").should route_to("sidebars#destroy", :id => "1")
    end

  end
end
