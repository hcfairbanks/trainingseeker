require 'rails_helper'
require 'spec_helper'

RSpec.describe "providers/index", type: :view do
  before(:each) do
    assign(:providers, [
      Provider.create!(
        :name => "Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :city => "City",
        :province_state => "Province State",
        :postal_code => "Postal Code",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2"
      ),
      Provider.create!(
        :name => "Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :city => "City",
        :province_state => "Province State",
        :postal_code => "Postal Code",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2"
      )
    ])
  end

  pending "renders a list of providers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Province State".to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 2".to_s, :count => 2
  end
end
