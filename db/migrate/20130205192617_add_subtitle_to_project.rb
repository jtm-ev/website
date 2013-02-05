class AddSubtitleToProject < ActiveRecord::Migration
  def change
    add_column :projects, :subtitle, :string
    remove_column :projects, :year
    remove_column :projects, :genre
  end
end
