class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :seats
  after_create :send_payment
  after_update :send_emails_on_success
  before_create :set_total_price_and_number_of_seats

  attr_accessor :card_name, :credit_card_number, :expiry_month, :expiry_year, :cvd

  validates :card_name, presence: true
  validates :course, presence: true
  validates :user, presence: true
  validates :credit_card_number, presence: true
  validates :expiry_month, presence: true
  validates :expiry_year, presence: true
  validates :cvd, presence: true
  validate :has_at_least_one_seat

  accepts_nested_attributes_for :seats

  enum status: {created: 0, succeeded: 1, pending: 2, failed: 3, refund_pending: 4, refunded: 5}

  def total_price_in_cents
    course.price_in_cents * seats.size
  end

  def total_price
    (self.total_price_in_cents/100.0).round(2)
  end

  private

  def set_total_price_and_number_of_seats
    #would be nicer to have default to created..
    self.status = :created
    self.number_of_seats = seats.size
    self.price = total_price
  end

  def send_payment
    payment_attempt = SendPayment.new(self)
    payment_attempt.run
  end

  def send_emails_on_success
    if self.status_changed? && self.status == "succeeded"
      SendSeatConfirmationEmailsJob.perform_later self
    end
  end

  def has_at_least_one_seat
    if seats.empty?
      errors.add(:seats, "- must have at least one")
    end
  end
end
