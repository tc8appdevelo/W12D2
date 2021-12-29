class SessionsController < ApplicationController
    
    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if user.nil?
            flash.now[:errors] = ["Invalid credentials!"]
        elsif !user.activated?
            flash.now[:errors] = ['activate account first']
        else
            login_user!(user)
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
    end
end