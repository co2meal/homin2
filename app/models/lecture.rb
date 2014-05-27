class Lecture < ActiveRecord::Base
  validates :lid, uniqueness: true

  
  def color
    '#' + id.hash.abs.to_s(16)[0,6]
  end
end
