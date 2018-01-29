require 'rails_helper'

RSpec.describe "course_names/edit", type: :view do
  before(:each) do
    @course_name = assign(:course_name, CourseName.create!(
      :name => "MyString",
      :course_type => 1
    ))
  end

  pending "renders the edit course_name form" do
    render

    assert_select "form[action=?][method=?]", course_name_path(@course_name), "post" do

      assert_select "input#course_name_name[name=?]", "course_name[name]"

      assert_select "input#course_name_course_type[name=?]", "course_name[course_type]"
    end
  end
end
