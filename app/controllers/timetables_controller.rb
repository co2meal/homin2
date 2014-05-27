class TimetablesController < ApplicationController
	def common_table
		@timetable = Timetable.new
	end

	def new
		@timetable = Timetable.new
	end

	def show
		@timetable = Timetable.find(params[:id])
	end

	def create

		@timetable = current_user.timetables.new
		if params[:sid]

			no_sids = params['sid'] - User.where("sid IN (?)", params['sid']).select(:sid).map(&:sid)
			no_sids.each do |sid|
				user = User.create(sid: sid)
			end

			User.where("sid IN (?)", params['sid']).each do |user|
				user.taking_lectures.where("time IS NOT NULL").each do |lecture|
					@timetable.items.new user: user, lecture: lecture
				end
			end
		end

		@timetable.name = User.where("sid IN (?)", params['sid']).map{|user| user.name or user.sid }.join(" ")
		@timetable.save!

		redirect_to @timetable

	end

	def common_table2
	end
end
