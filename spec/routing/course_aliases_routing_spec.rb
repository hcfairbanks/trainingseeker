require "rails_helper"

RSpec.describe CourseAliasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/course_aliases").to route_to("course_aliases#index")
    end

    it "routes to #new" do
      expect(:get => "/course_aliases/new").to route_to("course_aliases#new")
    end

    it "routes to #show" do
      expect(:get => "/course_aliases/1").to route_to("course_aliases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/course_aliases/1/edit").to route_to("course_aliases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/course_aliases").to route_to("course_aliases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/course_aliases/1").to route_to("course_aliases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/course_aliases/1").to route_to("course_aliases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/course_aliases/1").to route_to("course_aliases#destroy", :id => "1")
    end

  end
end
