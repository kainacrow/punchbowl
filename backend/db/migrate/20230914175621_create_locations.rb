class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :location_id
      t.string :name
      t.float :lat
      t.float :lon
      t.timestamps
    end

    add_index :locations, :location_id, unique: true
  end
end
