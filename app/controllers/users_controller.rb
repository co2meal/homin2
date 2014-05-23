class UsersController < ApplicationController
	def update
		current_user.sid=params[:user][:sid]
		current_user.save!
		#raise 'dfr'
		redirect_to :root
	end
end
