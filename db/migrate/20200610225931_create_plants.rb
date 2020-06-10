class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.integer :num_water_day
      t.integer :num_fert_day
      t.integer :num_prune_day
      t.integer :location_id
      t.timestamps
    end   
  end
end
