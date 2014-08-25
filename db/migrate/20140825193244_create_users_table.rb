class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password
  		t.integer :profile
  		t.integer :post
  		
  	end
  end
end
