class AddUploadToMembers < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.integer     :width
      t.integer     :height

      t.attachment  :file
      t.string      :file_fingerprint
      t.text        :file_meta
    end
  end
end
