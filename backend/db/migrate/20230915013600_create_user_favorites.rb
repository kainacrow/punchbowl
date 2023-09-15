class CreateUserFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :user_favorites do |t|
      t.references :user, foreign_key: true
      t.string :location_id, foreign_key: true
      t.timestamps
    end
  end
end
