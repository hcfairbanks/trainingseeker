class Role < ActiveRecord::Base
  SITE_ADMIN_ROLE_NAME = "site_admin"
  BUSINESS_ADMIN_ROLE_NAME = "business_admin"
  PROVIDER_AGENT_ROLE_NAME = "provider_agent"
  HR_AGENT_ROLE_NAME = "hr_agent"
  #has_many :assignments
  has_many :users#, through: :assignments
  validates :name, presence: true

  def self.registrable
    Role.where(name: [PROVIDER_AGENT_ROLE_NAME, HR_AGENT_ROLE_NAME]).all
  end
end
