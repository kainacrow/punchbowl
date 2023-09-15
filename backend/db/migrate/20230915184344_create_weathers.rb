class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.string :location_id
      t.json :json_data

      t.timestamps
    end
  end
end
