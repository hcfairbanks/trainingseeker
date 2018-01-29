require 'rails_helper'

RSpec.describe "course_names/index", type: :view do
  before(:each) do
    assign(:course_names, [
      CourseName.create!(
        :name => "Name",
        :course_type => 2
      ),
      CourseName.create!(
        :name => "Name",
        :course_type => 2
      )
    ])
  end

  pending "renders a list of course_names" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
