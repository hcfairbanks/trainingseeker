class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  private
    def sign_up_params
      parameters = params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
      parameters[:role_id] = nil if !Role.registrable.map(&:id).include?(parameters[:role_id].to_i)
      parameters
    end

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end
end
