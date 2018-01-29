class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy, :approve]

  def index
    #ExampleMailer.sample_email(User.first).deliver
    if params[:q].nil?
      @q = User.ransack(params[:q])
    else
      @q = User.ransack(email_matches: params[:q][:email], id_matches: params[:q][:id], is_approved_not_eq: params[:q][:is_approved])
    end
    @users = @q.result.paginate(:page => params[:page],per_page: 5)
  end

  def show
    #byebug
    #UserMailer.account_approved(User.find(1))
  end
  def new
    @direction = create_user_no_devise_path
    @user = User.new
  end

  def edit
    @direction = "/update_user_no_devise/#{@user.id}"
  end

  def create
    adjusted_params = pw_present(user_params)

    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: t("user.successfully-created")
    else
      render :new
    end
  end

  def update
    if user_params[:role_id]
      if user_params[:role_id].to_i == Role.where(name: Role::SITE_ADMIN_ROLE_NAME).first.id
        authorize! :assign_site_admin_role, @user
      else
        authorize! :assign_role, @user
      end
    end
    authorize! :assign_provider, @user if user_params[:provider_id]

    if @user.update(pw_present(user_params))
      redirect_to @user, notice: t("user.successfully-updated")
    else
      render :edit
    end

  end

  def destroy
    redirect_location = ""
    notice = t("user.successfully-destroyed")
    if current_user.id == @user.id
      if @user.destroy
        redirect_location = new_user_session_url
      end
    elsif @user.destroy
      redirect_location = users_path
    else
      byebug
      redirect_location = root_path
      notice = "#{t("user.not-successfully-destroyed")} #{t("sys_admin")}"
    end
    redirect_to redirect_location, notice: notice
  end

  def approve
    notice = t("user.successfully-approved")
    @user.update_attribute(:is_approved, true)
    redirect_to users_path, notice: notice
  end

  private

    def pw_present(old_params)
      new_params = {}
      if old_params[:password].blank? && old_params[:password_confirmation].blank?
        new_params = old_params.extract!(:id,
                                         :avatar,
                                         :first_name,
                                         :provider_id,
                                         :last_name,
                                         :city,
                                         :province,
                                         :email,
                                         :dob,
                                         :role_id)
      end
      new_params
    end

    def set_user
      @user = User.find(params[:id])
      session[:user_id] = @user.id
    end

    def user_params
      params.require(:user).permit( :id,
                                    :avatar,
                                    :first_name,
                                    :provider_id,
                                    :last_name,
                                    :password,
                                    :password_confirmation,
                                    :city,
                                    :province,
                                    :dob,
                                    :email,
                                    :role_id,
                                    provider_accounts:[]
                                  )
    end
end
