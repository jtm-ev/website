class AddPositionToPages < ActiveRecord::Migration
  def change
    remove_column :pages, :order
    add_column :pages, :position, :integer
  end
end
