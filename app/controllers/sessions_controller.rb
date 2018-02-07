class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in(user, params[:session][:remember_me])
			flash[:success] = "Willkomen #{user.name}"
			redirect_back_or orders_path
		else
			# Use flash.now for disapear website
			flash.now[:danger] = 'Falsches Login'
			render 'new'
		end
	end

	def destroy
		sign_out
    	redirect_to root_url
	end
end
