class AddSegmentToTeams < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.string :segment
    end
  end
end
