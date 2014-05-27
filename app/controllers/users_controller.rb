class UsersController < ApplicationController
  before_action :check_users_informations_are_lack, except: [:register, :update]
  
  def check_users_informations_are_lack
    if current_user.nil?
      redirect_to :facade_index
      return
    end
    if current_user.sid.blank?
      redirect_to :users_register
      return
    end
  end


	def update
		User.where(sid:params[:user][:sid]).map(&:destroy)
		current_user.sid=params[:user][:sid]
		current_user.save!
		redirect_to :root
	end
end
