FactoryGirl.define do
  factory :payment do
    user nil
    course nil
    number_of_seats 1
    price 1.5
    status 1
    response_id "MyString"
    full_response "MyText"
  end
end
