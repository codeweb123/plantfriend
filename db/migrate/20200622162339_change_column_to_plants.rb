class ChangeColumnToPlants < ActiveRecord::Migration
  def change
    change_column :plants, :location_id, :string
    change_column :plants, :user_id, :string
  end
end
