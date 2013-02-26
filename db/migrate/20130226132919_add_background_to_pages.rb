class AddBackgroundToPages < ActiveRecord::Migration
  def change
    add_column :pages, :background_id, :integer
  end
end
