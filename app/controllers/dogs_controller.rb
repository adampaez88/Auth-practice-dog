class DogsController < ApplicationController
    def index 
        dogs = Dog.all
        render json: dogs
    end 

    def create
        authorization_header = request.headers[:authorization]
        if !authorization_header
            render status: :unauthorized
        else
            token = authorization_header.split(' ')[1]
            secret_key = Rails.application.secrets.secret_key_base[0]
            decoded_token = JWT.decode(token, secret_key)

            user = User.find(decoded_token[0]['user_id'])

            dog = Dog.create(
                name: params[:name],
                breed: params[:breed],
                age: params[:age],
                user: user
            )
            render json: {dog: dog}
        end
    end 
end
