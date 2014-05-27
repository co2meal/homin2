class CreateTimetable < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.references :user, index: true
      t.string :name
    end
  end
end
