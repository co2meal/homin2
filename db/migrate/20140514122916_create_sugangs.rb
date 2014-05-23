class CreateSugangs < ActiveRecord::Migration
  def change
    create_table :sugangs do |t|
 		t.belongs_to :user
  		t.belongs_to :lecture 
 	 	t.string :status
    	t.timestamps
    end
  end
end
