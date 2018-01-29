require 'rails_helper'

RSpec.describe "course_aliases/show", type: :view do
  before(:each) do
    @course_alias = assign(:course_alias, CourseAlias.create!(
      :course_alias => "Course Alias",
      :course_name_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Course Alias/)
    expect(rendered).to match(/2/)
  end
end
