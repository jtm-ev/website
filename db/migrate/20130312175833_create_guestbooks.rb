class CreateGuestbooks < ActiveRecord::Migration
  def change
    create_table :guestbooks do |t|
      t.text :content
      t.string :name
      t.string :website
      t.string :email
      t.integer :project_id

      t.timestamps
    end
  end
end
