class AddWidthAndHightToUploads < ActiveRecord::Migration
  def change
    add_column :project_files, :width, :integer
    add_column :project_files, :height, :integer
    add_column :page_files, :width, :integer
    add_column :page_files, :height, :integer
  end
end
