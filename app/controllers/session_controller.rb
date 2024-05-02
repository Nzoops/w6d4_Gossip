class SessionController < ApplicationController
  def new
    # @session = Session.new
  end

  def create
      # cherche s'il existe un utilisateur en base avec l’e-mail
      @user = User.find_by(email: user_params[:email])
    
      # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
      if @user && @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{session[:user_id]}"
        flash[:success] = "login success!"
        redirect_to root_path
        # redirige où tu veux, avec un flash ou pas
      else
        puts "llllllllllllllllllllll#{session[:user_id]}"
        flash.now[:danger] = 'Invalid email/password combination'
        redirect_to new_session_path
      end

  end

  def destroy
    @session = User.find_by(email: user_params[:email])
    @session.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
