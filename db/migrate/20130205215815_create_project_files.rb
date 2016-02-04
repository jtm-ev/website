class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.integer :project_id
      
      t.string :description
      t.string :kind
      
      t.attachment  :file
      t.string      :file_fingerprint
      t.text        :file_meta

      t.timestamps
    end
  end
end
