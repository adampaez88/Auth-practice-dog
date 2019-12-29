class UsersController < ApplicationController
    def create 
        users = User.create(
            name: params[:name],
            email: params[:email],
            username: params[:username],
            password: params[:password]
        )
        render json: users
    end 
end
