class AddVideosToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :videos, :text;
  end
end
