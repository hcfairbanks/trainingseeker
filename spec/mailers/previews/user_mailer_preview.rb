class UserMailerPreview < ActionMailer::Preview
  def account_approved
    UserMailer.account_approved(User.provider_agents.first)
  end

  def account_approval_pending
    UserMailer.account_approval_pending(User.provider_agents.first)
  end

  def seat_confirmed
    UserMailer.seat_confirmed(Seat.purchased.first)
  end

  def purchase_confirmed
    UserMailer.purchase_confirmed(Purchase.where(status: :succeeded).first)
  end
end
