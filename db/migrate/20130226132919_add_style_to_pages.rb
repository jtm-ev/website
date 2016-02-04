class AddStyleToPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.integer :background_id
      t.string  :navigation_style
      t.string  :body_background
      t.string  :content_background
    end
  end
end
