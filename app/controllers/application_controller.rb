class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :authorized, only: [:index, :edit, :update, :delete, :show, :admin]
    @admin = 1
    @user  = 0
    helper_method :logged_in?, :current_user

    def current_user
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        redirect_to login_path unless logged_in?
    end
end
