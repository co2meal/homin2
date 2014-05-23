class TimetableController < ApplicationController
	before_filter :initiate
	
	def initiate
		if current_user.nil?
			redirect_to :facade_index
			return
		end
		if current_user.sid.blank?
			redirect_to :users_register
			return
		end
	end


	def common_table2
		if params['sid']
			no_sids = params['sid'] - User.where("sid IN (?)", params['sid']).select(:sid).map(&:sid)
			no_sids.each do |sid|
				user = User.create(sid: sid)
				user.crawl if not user.crawled?
			end

			@users = User.where("sid IN (?)", params['sid'])
		end
	end
end
