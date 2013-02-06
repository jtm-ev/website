
class ProjectFile < ActiveRecord::Base
  attr_accessible :file, :file_fingerprint, :file_meta, :kind, :description, :file_file_name, :meta
  
  serialize :meta, Hash
  
  belongs_to :project
  
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
  
  # Auto-Rotate gibt bei manchen Bildern Probleme (EXIF autoorient?): http://pjkh.com/articles/rails-paperclip-auto-orient-and-resizing/
  has_attached_file :file, {
    styles: {
      square: {geometry: '100x100#', format: :png},
      thumb:  {geometry: '120x120', format: :png},
      medium: {geometry: '540x540', format: :png},
      large:  {geometry: '1024x1024', format: :png} 
    },
    url: "/system/project_files/:hash.:extension",
    hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
  }
  
end