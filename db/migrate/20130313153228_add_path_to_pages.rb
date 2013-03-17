class AddPathToPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.string :path
    end
    
    add_index :pages, :path, unique: true
  end
end
