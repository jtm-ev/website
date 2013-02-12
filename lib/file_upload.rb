
module FileUpload
  extend ActiveSupport::Concern
  
  included do
    attr_accessible :file, :file_fingerprint, :file_meta, :description, :file_file_name, :meta
    serialize :meta, Hash
    
    # Auto-Rotate gibt bei manchen Bildern Probleme (EXIF autoorient?): http://pjkh.com/articles/rails-paperclip-auto-orient-and-resizing/
    # https://github.com/thoughtbot/paperclip/wiki/Interpolations
    has_attached_file :file, {
      styles: {
        square: {geometry: '100x100#', format: :png},
        thumb:  {geometry: '120x120', format: :png},
        medium: {geometry: '540x540', format: :png},
        large:  {geometry: '1024x1024', format: :png} 
      },
      convert_options: {
        square: "-quality 75 -strip"
      },
      url: "/system/project_files/:hash.:extension",
      hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
    }
    
    before_post_process :resize_images
  end
  
  
  def image?
    # also handle PDFs like images
    file_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png|pdf|x-pdf)$}
  end
  
  private

    def resize_images
      return false unless image?
    end
  
end