require "spec_helper"

describe BasketsController do
  describe "routing" do

    it "routes to #index" do
      get("/baskets").should route_to("baskets#index")
    end

    it "routes to #new" do
      get("/baskets/new").should route_to("baskets#new")
    end

    it "routes to #show" do
      get("/baskets/1").should route_to("baskets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/baskets/1/edit").should route_to("baskets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/baskets").should route_to("baskets#create")
    end

    it "routes to #update" do
      put("/baskets/1").should route_to("baskets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/baskets/1").should route_to("baskets#destroy", :id => "1")
    end

  end
end
