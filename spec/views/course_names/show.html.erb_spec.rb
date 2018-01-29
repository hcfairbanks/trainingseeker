require 'rails_helper'

RSpec.describe "course_names/show", type: :view do
  before(:each) do
    @course_name = assign(:course_name, CourseName.create!(
      :name => "Name",
      :course_type => 2
    ))
  end

  pending "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
