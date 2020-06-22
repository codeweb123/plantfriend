class ChangeColumnToLocations2 < ActiveRecord::Migration
  def change
    change_column :plants, :user_id, :integer
    change_column :plants, :location_id, :integer
  end
end
