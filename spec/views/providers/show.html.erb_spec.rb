require 'rails_helper'

RSpec.describe "providers/show", type: :view do
  before(:each) do
    @provider = assign(:provider, Provider.create!(
      :name => "Name",
      :phone_number => "Phone Number",
      :email => "Email",
      :city => "City",
      :province_state => "Province State",
      :postal_code => "Postal Code",
      :address_line_1 => "Address Line 1",
      :address_line_2 => "Address Line 2"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Province State/)
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(/Address Line 1/)
    expect(rendered).to match(/Address Line 2/)
  end
end
