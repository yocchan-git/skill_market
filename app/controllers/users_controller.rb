class UsersController < ApplicationController
    def index
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "新規登録が完了しました。"
            redirect_to users_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "更新に成功しました。"
            redirect_to user_path(@user)
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:notice] = "削除しました。"
        redirect_to users_path, status: :see_other
    end

    private

        def user_params
        params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
        end
end
