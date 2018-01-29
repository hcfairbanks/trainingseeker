FactoryGirl.define do
  factory :role do
    name "user"

    factory :site_admin_role do
      name Role::SITE_ADMIN_ROLE_NAME
      initialize_with { Role.find_or_create_by(name: name) }
    end

    factory :biz_admin_role do
      name Role::BUSINESS_ADMIN_ROLE_NAME
      initialize_with { Role.find_or_create_by(name: name) }
    end

    factory :provider_agent_role do
      name Role::PROVIDER_AGENT_ROLE_NAME
      initialize_with { Role.find_or_create_by(name: name) }
    end

    factory :hr_agent_role do
      name Role::HR_AGENT_ROLE_NAME
      initialize_with { Role.find_or_create_by(name: name) }
    end
  end

end
