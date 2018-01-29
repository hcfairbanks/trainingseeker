require "rails_helper"

RSpec.describe CourseNamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/course_names").to route_to("course_names#index")
    end

    it "routes to #new" do
      expect(:get => "/course_names/new").to route_to("course_names#new")
    end

    it "routes to #show" do
      expect(:get => "/course_names/1").to route_to("course_names#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/course_names/1/edit").to route_to("course_names#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/course_names").to route_to("course_names#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/course_names/1").to route_to("course_names#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/course_names/1").to route_to("course_names#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/course_names/1").to route_to("course_names#destroy", :id => "1")
    end

  end
end
