##
# Serves pages and contains actions related to the User Model
class UsersController < ApplicationController

    before_action :authenticate_user!

    def edit
        @user = User.find(params[:id])
    end

    def edit_password
    end

    def create_password
        @user = User.find_by(email:params[:password][:email].downcase)
        if @user
            @user.create_reset_digest
            @user.send_password_reset_mail
            redirect_to root_url
        else
            render 'new'
        end
    end

    def update
        @user = User.find(current_user.id)
        @user.update(user_params)
        redirect_to view_profile_path(current_user)
        # @user = User.find(current_user.id)
        # fields = user_params
        # fields.delete(:current_password) unless fields[:current_password].present?
        # update_succesful = fields[:password].present? ? @user.update_with_password(fields) : @user.update_without_password(fields)
        # if update_succesful
        #     # bypass validation in case their password changed
        #     sign_in @user, :bypass => true
        #     flash[:success] = 'Profile updated successfully.'
        #     redirect_to view_profile_path(current_user)
        # else
        #     render :edit
        # end
    end

    def show
        if params[:id]
            @user = User.find(params[:id])
        else
            @user = current_user
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if (@user.save)
            flash[:success] = "New user added successfully."
            # Email the user
            UserMailer.new_user_mail(user_params).deliver_now

            redirect_to view_profile_path
        else
            flash[:error] = "There was an error saving user."
            redirect_to new_user_path
        end
    end

    def index
        @users = User.get_users_other_than(current_user.id)
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
    end
end