require "rails_helper"

RSpec.describe SeatsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/seats").to route_to("seats#index")
    end

    it "routes to #new" do
      expect(:get => "/seats/new").to route_to("seats#new")
    end

    it "routes to #show" do
      expect(:get => "/seats/1").to route_to("seats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/seats/1/edit").to route_to("seats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/seats").to route_to("seats#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/seats/1").to route_to("seats#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/seats/1").to route_to("seats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/seats/1").to route_to("seats#destroy", :id => "1")
    end

  end
end
