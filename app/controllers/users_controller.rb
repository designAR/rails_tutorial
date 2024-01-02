class UsersController < ApplicationController

    before_action :correct_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        redirect_to(root_url, notice: "User not found") if @user.nil?
    end      

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_param)
        if @user.save
            redirect_to user_path(@user), notice: "User successfully created"
        else
            Rails.logger.info(@user.errors.inspect)
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_param)
            redirect_to user_path(@user), notice: 'ユーザー情報が更新されました。'
        else
            flash.now[:alert] = @user.errors.full_messages
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path, notice: 'ユーザーが削除されました。'
    end    

    private
        def user_param
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def correct_user
            @user = User.find_by(id: params[:id])
            unless @user && @user == current_user
            flash[:alert] = 'ユーザー情報に接近できません。。Loginしてください！'
            redirect_to root_path
        end
    end
end
