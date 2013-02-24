class AddUploadToTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :order
    remove_column :team_memberships, :order
    add_column :teams, :position, :integer
    add_column :team_memberships, :position, :integer
    
    change_table :teams do |t|
      t.integer     :width
      t.integer     :height
      
      t.attachment  :file
      t.string      :file_fingerprint
      t.text        :file_meta
    end
  end
  
  # def down
  #   
  # end
end
