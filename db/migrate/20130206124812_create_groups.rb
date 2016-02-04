class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :shortcut
      t.boolean :public
      t.integer :page_id
      t.string :description

      t.timestamps
    end
  end
end
