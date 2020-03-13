class FriendsPageController < ApplicationController
    def index
        @user = User.all
    end
end