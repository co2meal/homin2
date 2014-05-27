class UsersController < ApplicationController
	def update
		User.where(sid:params[:user][:sid]).map(&:destroy)
		current_user.sid=params[:user][:sid]
		current_user.save!
		redirect_to :root
	end
end
