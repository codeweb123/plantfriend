class ChangeColumnToLocations < ActiveRecord::Migration
  def change
    change_column :locations, :user_id, :integer
  end
end
