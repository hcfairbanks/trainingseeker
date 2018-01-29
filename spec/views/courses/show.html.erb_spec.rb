require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  before(:each) do
    @course = assign(:course, Course.create!(
      :name => "Name",
      :availability => "",
      :cost => "",
      :city => "City",
      :province => "Province",
      :address_line_1 => "Address Line 1",
      :address_line_2 => "Address Line 2",
      :postal_code => "Postal Code",
      :provider_id => ""
    ))
  end

  pending "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Province/)
    expect(rendered).to match(/Address Line 1/)
    expect(rendered).to match(/Address Line 2/)
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(//)
  end
end
