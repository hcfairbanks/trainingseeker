require 'rails_helper'

RSpec.describe "course_names/new", type: :view do
  before(:each) do
    assign(:course_name, CourseName.new(
      :name => "MyString",
      :course_type => 1
    ))
  end

  pending "renders new course_name form" do
    render

    assert_select "form[action=?][method=?]", course_names_path, "post" do

      assert_select "input#course_name_name[name=?]", "course_name[name]"

      assert_select "input#course_name_course_type[name=?]", "course_name[course_type]"
    end
  end
end
