class AddPositionToFiles < ActiveRecord::Migration
  def change
    add_column :project_files,  :position, :integer
    add_column :page_files,     :position, :integer
  end
end
