class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :public, default: true
      t.integer :project_id
      t.string :location

      t.timestamps
    end
  end
end
