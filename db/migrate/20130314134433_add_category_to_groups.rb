class AddCategoryToGroups < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.string :category
    end
  end
end
