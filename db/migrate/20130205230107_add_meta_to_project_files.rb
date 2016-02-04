class AddMetaToProjectFiles < ActiveRecord::Migration
  def change
    add_column :project_files, :meta, :text
  end
end
