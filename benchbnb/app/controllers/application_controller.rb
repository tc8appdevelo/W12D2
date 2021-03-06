class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    helper_method :current_user, :current_user_id, :logged_in?

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def current_user_id
        current_user ? current_user.id : nil
    end

    def logged_in?
        !!current_user
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def require_user!
        puts "require_user! did"
    end
end
