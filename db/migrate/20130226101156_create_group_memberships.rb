class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :group_id
      t.integer :member_id
      t.integer :position
      
      t.string :role

      t.timestamps
    end
  end
end
