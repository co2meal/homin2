class Timetable < ActiveRecord::Base
  # it has name
  belongs_to :user
  has_many :items, class_name: TimetableItem

  validates :name, uniqueness: {scope: :user_id}, presence: true

  def users
    User.find_all_by_id(items.select(:user_id).distinct.map(&:user_id))
  end
end
