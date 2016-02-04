class AddBirthDateFieldsToMembers < ActiveRecord::Migration
  def up
    add_column :members, :birth_day, :integer
    add_column :members, :birth_month, :integer
    
    Member.all.each do |m|
      m.save
    end
  end
  
  def down
    remove_column :members, :birth_day
    remove_column :members, :birth_month
  end
end
