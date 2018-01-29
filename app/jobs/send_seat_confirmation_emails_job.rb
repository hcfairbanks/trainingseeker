class SendSeatConfirmationEmailsJob < ApplicationJob
  queue_as :default

  def perform(purchase)
    purchase.seats.each do |seat|
      UserMailer.seat_confirmed(seat).deliver_later
    end
    UserMailer.purchase_confirmed(purchase).deliver_later
  end
end
