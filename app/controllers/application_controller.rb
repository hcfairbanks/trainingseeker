class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  protect_from_forgery with: :exception
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end


 # Devise role_ids
 # http://stackoverflow.com/questions/16379554/strong-parameters-with-rails-and-devise




  protected

  def permission_denied
    flash[:error] = "#{t("applications.access-denied")} #{t("sys_admin")}"
    redirect_to root_url
  end

  # def current_user_session
  #   return @current_user_session if defined?(@current_user_session)
  #   @current_user_session = UserSession.find
  # end
  #
  # def current_user
  #   return @current_user if defined?(@current_user)
  #   @current_user = current_user_session && current_user_session.record
  # end

end
