
class ProjectFile < ActiveRecord::Base
  attr_accessible :file, :file_fingerprint, :file_meta, :kind, :description, :file_file_name
  
  belongs_to :project
  has_attached_file :file, {
    styles: {thumb: '100x100#'},
    url: "/system/project_files/:hash.:extension",
    hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
  }
  
end