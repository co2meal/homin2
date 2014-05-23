class CreateTimetable < ActiveRecord::Migration
  def change
    create_table :timetable do |t|
      t.string :sid
      t.string :tid
      t.string :name
      t.string :lecture
      t.string :totcredit
      t.timestamps
  	end
  end
end
