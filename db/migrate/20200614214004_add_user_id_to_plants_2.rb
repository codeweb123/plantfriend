class AddUserIdToPlants2 < ActiveRecord::Migration
  def change
    add_column :plants, :user_id, :string
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
