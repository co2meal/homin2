class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :lid
      t.string :name
      t.string :time
      t.float :credit
      t.timestamps
    end
  end
end
