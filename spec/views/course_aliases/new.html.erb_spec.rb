require 'rails_helper'

RSpec.describe "course_aliases/new", type: :view do
  before(:each) do
    assign(:course_alias, CourseAlias.new(
      :course_alias => "MyString",
      :course_name_id => 1
    ))
  end

  it "renders new course_alias form" do
    render

    assert_select "form[action=?][method=?]", course_aliases_path, "post" do

      assert_select "input#course_alias_course_alias[name=?]", "course_alias[course_alias]"

      assert_select "input#course_alias_course_name_id[name=?]", "course_alias[course_name_id]"
    end
  end
end
