class AdminMailer < ApplicationMailer
  default from: ENV['SMTP_DEFAULT_FROM']

	def new_user_waiting_for_approval(recipient_email, user)
    @user = user
    @host = ENV['SMTP_BASE_URL']
    mail(to: recipient_email, subject: 'User has requested approval')
  end

end
