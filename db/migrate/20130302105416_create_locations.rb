class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :page_id
      t.string :name

      t.timestamps
    end
  end
end
