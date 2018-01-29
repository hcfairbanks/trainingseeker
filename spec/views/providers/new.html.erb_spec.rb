require 'rails_helper'

RSpec.describe "providers/new", type: :view do
  before(:each) do
    assign(:provider, Provider.new(
      :name => "MyString",
      :phone_number => "MyString",
      :email => "MyString",
      :city => "MyString",
      :province_state => "MyString",
      :postal_code => "MyString",
      :address_line_1 => "MyString",
      :address_line_2 => "MyString"
    ))
  end

  it "renders new provider form" do
    render

    assert_select "form[action=?][method=?]", providers_path, "post" do

      assert_select "input#provider_name[name=?]", "provider[name]"

      assert_select "input#provider_phone_number[name=?]", "provider[phone_number]"

      assert_select "input#provider_email[name=?]", "provider[email]"

      assert_select "input#provider_city[name=?]", "provider[city]"

      assert_select "input#provider_province_state[name=?]", "provider[province_state]"

      assert_select "input#provider_postal_code[name=?]", "provider[postal_code]"

      assert_select "input#provider_address_line_1[name=?]", "provider[address_line_1]"

      assert_select "input#provider_address_line_2[name=?]", "provider[address_line_2]"
    end
  end
end
