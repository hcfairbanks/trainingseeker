FactoryGirl.define do
  factory :user do
    first_name "Bob"
    last_name "Boberson"
    city "Halifax"
    province "Nova Scotia"
    # Don't know if I really need sequence here
    # Maybe just ensure none of the other user creates use this email ???
    sequence :email do |n|
      "#{first_name}#{n}@example.com"
    end
    password "password"
    password_confirmation "password"
    role
    dob "2016/6/16"

    trait :site_admin do
      association :role, factory: :site_admin_role
    end

    trait :biz_admin do
      association :role, factory: :biz_admin_role
    end

    trait :provider_agent do
      association :role, factory: :provider_agent_role
    end

    trait :hr_agent do
      association :role, factory: :hr_agent_role
    end
  end
end
