class RegisterController < ApplicationController

	def register
		if logged_in?
			redirect_to :action => 'main', :id => current_user.id
		else
			@user = User.new
		end
		
	end

	def CreateUser
		@user = User.create(reg_params)
		if @user.save
			redirect_to :action => 'main' ,:id => @user.id
		else
			render :register
		end
	end

	def main
		@user = User.find_by(id: params[:id])
	end

	def signin
		@user = User.new
	end

	def authenticateuser
		@user = User.find_by(emailid: params[:user][:emailid].downcase)
		if @user && @user.authenticate(params[:user][:password])
	      	log_in @user
	      	
		    redirect_to action: 'main', :id => current_user.id
	    else
	      flash[:notice] = 'Unknown user. Please check your username and password.'
	      redirect_to :action =>'signin'
	    end
	end

	def logout
		log_out
		flash[:logout] = 'You have been logged out successfully'
		redirect_to root_url
	end

	def reg_params
		params.require(:user).permit(:name, :emailid, :password, :password_confirmation)
	end
end
