class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :show, :index]
	before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :only_admin,     only: [:new, :create]


  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
 	end

 	def create
    @user = User.new(user_params)
    if @user.save
    	flash[:success] = "Welcome to the Bedellos Webshop!"
    	sign_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end

  # RESET Functionality
    # Password reset
  def show_password_reset
    render 'password_reset'
  end

  def password_reset
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset 
      flash[:success] = "Ein Mail wurde an ihre Adresse gesendet."
      redirect_to root_url
    else
      flash[:error] = "Zu dieser E-Mail Adresse ist kein Benutzer registriert."
      render 'password_reset'
    end  
  end

  def edit_password_reset
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update_password_reset
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Dieser Link ist abgelaufen, bitte lassen Sie sich einen neuen zukommen"
      render 'password_reset'
    elsif @user.update_attributes(user_params)
      sign_in @user
      redirect_to root_url, :notice => "Das Passwort wurde geändert"
    else
      render 'edit_password_reset'
    end    
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) or current_user.admin?
    end

    def only_admin
      if signed_in?
        redirect_to(root_url) unless current_user.admin?
      end
    end
end
