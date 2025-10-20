class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_sign_up_enabled, only: [:new, :create]

def create
    build_resource(sign_up_params)

    if User.count.zero?
      resource.role = "admin"
      resource.access_granted = true
    else
      resource.role = "employee"
      resource.access_granted = false
    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

    private

  def check_sign_up_enabled
  return if User.count.zero? # Allow first user to sign up

  unless Setting.first&.sign_ups_enabled?
    flash[:alert] = "Sign ups are currently disabled."
    redirect_to root_path
  end
end

private

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :image, :role, :access_granted, :sign_in_count)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :image, :role, :access_granted)
  end
end
