class AddSidToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :sid
  		
  	end
  end
end
