class TimetableItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :lecture
  belongs_to :timetable

  # validates :user_id, uniqueness: {scope: :lecture_id}
end
