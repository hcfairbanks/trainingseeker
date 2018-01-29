class Provider < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :provider_accounts

  has_many :photos, as: :external , dependent: :destroy
  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :provider_accounts, :reject_if => lambda { |a| a[:api_key].blank? }, :allow_destroy => true

  mount_uploader :avatar, AvatarUploader
  #validates_size_of :banner, maximum: 1.megabyte, message: "Attachment size exceeds the allowable limit ( 1 MB)."
  # PENDING = 0
  # APPROVED = 1
  # BLOCKED = 2
  #
  # belongs_to :user
  # belongs_to :friend, class_name: "User"
  # validates_uniqueness_of :user_id, scope: [:friend_id]
  # validates_uniqueness_of :friend_id, scope: [:user_id]

end
