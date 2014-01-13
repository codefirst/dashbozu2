require "spec_helper"

describe ActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/activities").should route_to("activities#all")
    end

    it "routes to #show" do
      get("/activities/1").should route_to("activities#show", :id => "1")
    end

  end
end
