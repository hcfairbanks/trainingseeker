class Course < ApplicationRecord
  belongs_to :provider
  belongs_to :course_name
  has_many :photos, as: :external , dependent: :destroy
  has_many :purchases
  accepts_nested_attributes_for :photos
  mount_uploader :avatar, AvatarUploader
  after_initialize do
    if self.new_record?
      self.price_in_cents = 100
      self.availability = 1
    end
  end

  def price=(val)
    self.price_in_cents = val.to_f * 100
  end

  def price
    self.price_in_cents / 100.0 if self.price_in_cents
  end

  # MIN_PRICE = "0"
  # MAX_PRICE = "1000000000"
  # MAX_DAYS_SEARCH = 80
  #
  # belongs_to :user
  #
  # has_many :photos, as: :external , dependent: :destroy
  # accepts_nested_attributes_for :photos
  #
  # validates :title, presence: true
  # validates :price, presence: true, numericality: true
  # validates_format_of :price, with: /\A\d{1,4}(.\d{0,2})?\z/
  # validates :user, presence: true


end
