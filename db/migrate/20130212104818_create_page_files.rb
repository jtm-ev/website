class CreatePageFiles < ActiveRecord::Migration
  def change
    create_table :page_files do |t|
      t.integer :page_id
      
      t.string :description
      
      t.attachment  :file
      t.string      :file_fingerprint
      t.text        :file_meta

      t.timestamps
    end
  end
end
