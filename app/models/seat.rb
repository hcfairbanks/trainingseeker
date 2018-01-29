class Seat < ApplicationRecord
  belongs_to :purchase

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  scope :purchased, -> { joins(:purchase).where(purchases: {status: :succeeded}) }

  def full_name
    [self.first_name, self.middle_name, self.last_name].compact.join(' ')
  end
end
