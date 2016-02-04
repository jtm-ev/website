class AddLocationToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.integer :location_id
    end
  end
end
