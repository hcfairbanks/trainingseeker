class UserMailer < ApplicationMailer
  default from: ENV['SMTP_DEFAULT_FROM']
  add_template_helper(SeatsHelper)


	def account_approved(user)
    @host = Settings.base_url
    @user = user
    @url  = ENV['SMTP_BASE_URL']
    mail(to: user.email, subject: 'Your application as been approved')
  end

	def account_approval_pending(user)
    @host = Settings.base_url
    @user = user
    mail(to: user.email, subject: 'Your application is waiting approval')
  end

  def seat_confirmed(seat)
    @host = Settings.base_url
    @seat = seat
    @course = seat.purchase.course
    @course_name = @course.course_name.try(:name) || @course.id
    mail(to: seat.email, subject: "Your seat for the course #{@course_name} is confirmed")
  end

  def purchase_confirmed(purchase)
    @host = Settings.base_url
    @purchase = purchase
    @course = purchase.course
    @course_name = @course.course_name.try(:name) || @course.id
    mail(to: purchase.user.email, subject: "Your purchase for the course #{@course_name} is confirmed")
  end
end
