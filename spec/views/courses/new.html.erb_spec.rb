require 'rails_helper'

RSpec.describe "courses/new", type: :view do
  before(:each) do
    assign(:course, Course.new(
      :course_name => FactoryGirl.create(:course_name),
      :availability => "",
      :price => "",
      :city => "MyString",
      :province => "MyString",
      :address_line_1 => "MyString",
      :address_line_2 => "MyString",
      :postal_code => "MyString",
      :provider_id => ""
    ))
  end

  pending "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do

      assert_select "input#course_name[name=?]", "course[name]"

      assert_select "input#course_availability[name=?]", "course[availability]"

      assert_select "input#course_cost[name=?]", "course[cost]"

      assert_select "input#course_city[name=?]", "course[city]"

      assert_select "input#course_province[name=?]", "course[province]"

      assert_select "input#course_address_line_1[name=?]", "course[address_line_1]"

      assert_select "input#course_address_line_2[name=?]", "course[address_line_2]"

      assert_select "input#course_postal_code[name=?]", "course[postal_code]"

      assert_select "input#course_provider_id[name=?]", "course[provider_id]"
    end
  end
end
