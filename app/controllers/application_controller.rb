## 
# General application-wide actions
class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters

        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password) }
    end

    # After the User logs in, redirect them to the Home Page
    def after_sign_in_path_for(resource)
        home_path
    end

    # After the User logs out, redirect them to the Login Page
    def after_sign_out_path(resource_or_scope)
        login_path
    end
end
