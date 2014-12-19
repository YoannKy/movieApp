class Users < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :pseudo
  		t.string :password
  		t.timestamps
  	end
  end
end
