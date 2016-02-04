class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :content
      t.text :to
      
      t.string :state

      t.integer :user_id

      t.timestamps
    end
  end
end
