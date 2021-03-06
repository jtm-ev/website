class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.integer :team_id
      t.integer :member_id
      t.integer :order
      
      t.string :role
      t.string :description
      
      t.boolean :public, default: true
      
      t.timestamps
    end
  end
end
