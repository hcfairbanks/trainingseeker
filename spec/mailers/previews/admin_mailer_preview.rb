class AdminMailerPreview < ActionMailer::Preview
  def new_user_waiting_for_approval
    AdminMailer.new_user_waiting_for_approval(User.site_admins.first.email, User.provider_agents.first)
  end
end
