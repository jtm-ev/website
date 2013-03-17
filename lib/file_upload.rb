# Crop Images using JS: http://mfischer.com/wordpress/2009/02/02/multiple-image-upload-and-crop-with-rails/comment-page-1/

module FileUpload
  extend ActiveSupport::Concern
  
  included do
    attr_accessible :file, :file_fingerprint, :file_meta, :description, :file_file_name, :meta
    serialize :meta, Hash
    
    delegate :url, to: :file
    
    # Auto-Rotate gibt bei manchen Bildern Probleme (EXIF autoorient?): http://pjkh.com/articles/rails-paperclip-auto-orient-and-resizing/
    # https://github.com/thoughtbot/paperclip/wiki/Interpolations
    has_attached_file :file, {
      styles: lambda { |asset|
        image_format = asset.instance.transparent? ? :png : :jpg
        lc_style = { geometry: '1024x576#', format: image_format }

        {
          square:     {geometry: '150x150#',  format: image_format},
          square_300: {geometry: '300x300#',  format: image_format},
          normal:     {geometry: '350x',      format: image_format},
          large:      {geometry: '1024x',     format: image_format},
          large_cinema: lc_style
        }
      },
      convert_options: {
        # all: '-auto-orient '
        # all: '-orient top-left'
        # large_cinema: '-gravity North'
        # square: "-quality 75 -strip",
        # thumb:  "-quality 75 -strip",
        # large:  "-quality 100 -strip"  
      },
      
      # url: "/system/project_files/:hash.:extension",
      hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
    }
    
    before_post_process :resize_and_init_images
        
    scope :landscape, lambda { where("width > height") }
    scope :portrait, lambda { where("height >= width") }
  end
  
  def has_image?
    !self.file_file_name.nil?
  end
  
  def transparent?
    file_file_name =~ %r{\.(gif|png|pdf)$}
  end
  
  def image?
    # also handle PDFs like images
    true #file_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png|pdf|x-pdf)$}
  end
  
  def landscape?
    return false unless (self.width && self.height)
    self.width > self.height
  end
  
  def portrait?
    !landscape?
  end
  
  # private

    def resize_and_init_images
      if image?
        geo = Paperclip::Geometry.from_file file.queued_for_write[:original]
        
        self.width = geo.width.to_i
        self.height = geo.height.to_i
        
        return true
      end
      
      false
    end
  
end