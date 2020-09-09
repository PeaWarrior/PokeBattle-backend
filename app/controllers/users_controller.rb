class UsersController < ApplicationController
    skip_before_action :authenticate, only: [:create, :login]

    def index
        users = User.where(active: [true])
        render json: users, each_serializer: UserSerializer
    end

    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token({ user_id: user.id })
            render json: { user: UserSerializer.new(user), token: token } , status: :created
        else
            render json: { error: user.errors.full_messages }, status: :bad_request
        end
    end

    def login
        user = User.find_by(username: user_params[:username])

        if user && user.authenticate(user_params[:password])
            token = encode_token({ user_id: user.id })
            render json: { user: UserSerializer.new(user), token: token}, include: '**'
        else
            render json: { error: "Invalid username or password" }, status: :unauthorized
        end
    end

    def autologin
        render json: { user: UserSerializer.new(@current_user) }, include: '**', status: :created
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
