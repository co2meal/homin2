class Lecture < ActiveRecord::Base
  validates :lid, uniqueness: true
end
