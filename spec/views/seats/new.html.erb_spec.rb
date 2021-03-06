require 'rails_helper'

RSpec.describe "seats/new", type: :view do
  before(:each) do
    assign(:seat, Seat.new(
      :first_name => "MyString",
      :middle_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :id_code => "MyString",
      :course_id => 1,
      :user_id => ""
    ))
  end

  it "renders new seat form" do
    render

    assert_select "form[action=?][method=?]", seats_path, "post" do

      assert_select "input#seat_first_name[name=?]", "seat[first_name]"

      assert_select "input#seat_middle_name[name=?]", "seat[middle_name]"

      assert_select "input#seat_last_name[name=?]", "seat[last_name]"

      assert_select "input#seat_email[name=?]", "seat[email]"

      assert_select "input#seat_phone[name=?]", "seat[phone]"

      assert_select "input#seat_id_code[name=?]", "seat[id_code]"

      assert_select "input#seat_course_id[name=?]", "seat[course_id]"

      assert_select "input#seat_user_id[name=?]", "seat[user_id]"
    end
  end
end
