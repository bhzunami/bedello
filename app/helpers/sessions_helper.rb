module SessionsHelper

	def sign_in(user, remember = false)
    remember_token = User.new_remember_token
    if remember
    	cookies.permanent[:remember_token] = remember_token 
  	else
  		cookies[:remember_token] = remember_token
  	end
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

# Checks if the user is signed in
  def signed_in?
    !current_user.nil?
  end

# sets the @current_user varuable
  def current_user=(user)
    @current_user = user
  end

# Set the @current_user variable
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

# This method checks if the loged in user is the user who wants to be edited
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
   end

  # Signout stuff
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
		redirect_to(session[:return_to] || default )
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

	def signed_in_user
  	unless signed_in?
  		store_location
  		redirect_to login_url, notice: "Bitte zuerst einloggen"
  	end
  end

  def admin_user
    store_location
    redirect_to(root_url) unless admin?
  end

  def admin?
    if current_user
      current_user.admin?
    else
      return false
    end
  end



end