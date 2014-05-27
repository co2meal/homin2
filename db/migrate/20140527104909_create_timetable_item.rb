class CreateTimetableItem < ActiveRecord::Migration
  def change
    create_table :timetable_items do |t|
      t.references :user, index: true
      t.references :lecture, index: true
      t.references :timetable, index: true
    end
  end
end
