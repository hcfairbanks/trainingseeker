require 'rails_helper'

RSpec.describe "seats/index", type: :view do
  before(:each) do
    assign(:seats, [
      Seat.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :email => "test@example.com",
        :phone => "Phone",
        :id_code => "Id Code",
        :course_id => 2,
        :user_id => ""
      ),
      Seat.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :email => "test@example.com",
        :phone => "Phone",
        :id_code => "Id Code",
        :course_id => 2,
        :user_id => ""
      )
    ])
  end

  pending "renders a list of seats" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middle Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Id Code".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
