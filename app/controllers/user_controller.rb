class UserController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User Created!" #pour afficher le bandeau alerte (Voir html new)
      redirect_to root_path
    else
      flash[:failure] = "Nope"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :age)
  end
end