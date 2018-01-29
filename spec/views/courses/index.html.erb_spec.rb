require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        :name => "Name",
        :availability => "",
        :cost => "",
        :city => "City",
        :province => "Province",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :postal_code => "Postal Code",
        :provider_id => ""
      ),
      Course.create!(
        :name => "Name",
        :availability => "",
        :cost => "",
        :city => "City",
        :province => "Province",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :postal_code => "Postal Code",
        :provider_id => ""
      )
    ])
  end

  pending "renders a list of courses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Province".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 2".to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
