class AddPositionToLocations < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.integer :position
    end
  end
end
