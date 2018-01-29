require 'rails_helper'

RSpec.describe "course_aliases/index", type: :view do
  before(:each) do
    assign(:course_aliases, [
      CourseAlias.create!(
        :course_alias => "Course Alias",
        :course_name_id => 2
      ),
      CourseAlias.create!(
        :course_alias => "Course Alias",
        :course_name_id => 2
      )
    ])
  end

  pending "renders a list of course_aliases" do
    render
    assert_select "tr>td", :text => "Course Alias".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
