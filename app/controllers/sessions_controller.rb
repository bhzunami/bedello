class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:email].downcase) 
		if user && user.authenticate(params[:password])
			sign_in(user, params[:remember_me])
			flash[:success] = "Willkomen #{user.name} im Admin bereich."
			redirect_back_or allProducts_path
		else
			# Use flash.now for disapear website
			flash.now[:error] = 'Flasches Logindaten'
			render 'new'
		end
	end

	def destroy
		sign_out
    redirect_to root_url
	end
end
