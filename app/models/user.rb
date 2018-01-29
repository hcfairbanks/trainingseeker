class User < ActiveRecord::Base

  belongs_to :provider
  #before_create :skip_confirmation, if: :is_provider_agent?
  #after_create :send_approval_request, if: :is_provider_agent?
  #after_create :send_approval_pending_notification, if: :is_provider_agent?
  #after_save :send_approved_notification, if: :is_approved_changed?

  validates :role_id, presence: true

  # http://stackoverflow.com/questions/8186584/how-do-i-set-up-email-confirmation-with-devise
  # https://github.com/plataformatec/devise/wiki/How-To:-Add-:confirmable-to-Users
  # https://www.youtube.com/watch?v=tkvXjYRNYmU

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # validates :first_name, presence: true
  # validates :role_ids, presence: true

  # validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  # validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true



  #has_many :assignments
  #has_many :roles, through: :assignments

  #has_many :posts, dependent: :destroy
  #has_and_belongs_to_many :communities
  # has_one :image, as: :external , dependent: :destroy
  # accepts_nested_attributes_for :image, reject_if: :image.blank?

  has_many :purchases

  #has_one :role
  belongs_to :role

  scope :biz_admins, -> { joins(:role).where(roles: {name: Role::BUSINESS_ADMIN_ROLE_NAME}) }
  scope :site_admins, -> { joins(:role).where(roles: {name: Role::SITE_ADMIN_ROLE_NAME}) }
  scope :provider_agents, -> { joins(:role).where(roles: {name: Role::PROVIDER_AGENT_ROLE_NAME}) }

  mount_uploader :avatar, AvatarUploader


  # def role_symbols
  #   roles.map do |role|
  #     role.name.underscore.to_sym
  #   end
  # end

  def is_site_admin?
    has_role_by_name?(Role::SITE_ADMIN_ROLE_NAME)
  end

  def is_business_admin?
    has_role_by_name?(Role::BUSINESS_ADMIN_ROLE_NAME)
  end

  def is_provider_agent?
    has_role_by_name?(Role::PROVIDER_AGENT_ROLE_NAME)
  end

  def is_hr_agent?
    has_role_by_name?(Role::HR_AGENT_ROLE_NAME)
  end

  def active_for_authentication?
    super && (!is_provider_agent? || is_approved?)
  end

  def assignable_role_names
    if self.is_site_admin?
      [Role::SITE_ADMIN_ROLE_NAME, Role::BUSINESS_ADMIN_ROLE_NAME, Role::PROVIDER_AGENT_ROLE_NAME, Role::HR_AGENT_ROLE_NAME]
    elsif self.is_business_admin?
      [Role::BUSINESS_ADMIN_ROLE_NAME, Role::PROVIDER_AGENT_ROLE_NAME, Role::HR_AGENT_ROLE_NAME]
    else
      []
    end
  end

  def assignable_roles
    Role.where(name: self.assignable_role_names).all
  end

  def inactive_message
    if is_provider_agent? && !is_approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  private

  def skip_confirmation
    self.skip_confirmation!
  end

  def has_role_by_name?(role_name)
    self.role.try(:name) == role_name
  end

  def send_approval_request
    User.biz_admins.each do |biz_admin|
      AdminMailer.new_user_waiting_for_approval(biz_admin.email, self).deliver_later
    end
  end

  def send_approval_pending_notification
    UserMailer.account_approval_pending(self).deliver_later
  end

  def send_approved_notification
    UserMailer.account_approved(self).deliver_later
  end

end
