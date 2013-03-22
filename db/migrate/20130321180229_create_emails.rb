class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :content
      t.text :addresses
      t.string :state

      t.timestamps
    end
  end
end
