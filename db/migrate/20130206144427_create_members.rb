class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :first_name
      t.string :birth_name
      t.string :street
      t.string :city
      t.string :phone
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :email_extern
      t.date :birthday
      t.date :member_since
      t.integer :school
      t.string :gender
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
