class RenameUsersColumns < ActiveRecord::Migration
  def change
  	rename_column(:users, :profile, :profile_id)
  	rename_column(:users, :post, :post_id)
  end
end
