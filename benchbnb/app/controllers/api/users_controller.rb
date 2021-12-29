class Api::UsersController < ApplicationController


    def create
        @user = User.new(user_params)
        if @user.save
            @user.activate!
            login_user!(@user)
            puts "inside of create and if @user.save login_user!(@user)"
        else
            flash.now[:errors] = @user.errors.full_messages
            puts "inside else in create, @user.save false"
        end
    end

    def activate
        @user = User.find_by(activation_token: params[:activation_token])
        @user.activate!
        login_user!(@user)
        flash[:notice] = 'Successfully logged in'
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
