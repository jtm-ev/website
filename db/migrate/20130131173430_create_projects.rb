class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.string :genre

      t.timestamps
    end
  end
end
