class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :parent_id
      t.string :title
      t.text :content
      t.boolean :show_in_navigation
      t.integer :order
      t.boolean :public

      t.timestamps
    end
  end
end
