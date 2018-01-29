require 'rails_helper'

RSpec.describe "course_aliases/edit", type: :view do
  before(:each) do
    @course_alias = assign(:course_alias, CourseAlias.create!(
      :course_alias => "MyString",
      :course_name_id => 1
    ))
  end

  it "renders the edit course_alias form" do
    render

    assert_select "form[action=?][method=?]", course_alias_path(@course_alias), "post" do

      assert_select "input#course_alias_course_alias[name=?]", "course_alias[course_alias]"

      assert_select "input#course_alias_course_name_id[name=?]", "course_alias[course_name_id]"
    end
  end
end
