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
        instance = asset.instance
        image_format = instance.image_format        
        {
          square:     instance.square_style(150),
          square_300: instance.square_style(300),
          normal:     {geometry: '350x', format: image_format},
          large:      {geometry: '1024x', format: image_format},
          large_cinema: instance.cinema_style(1024)
        }
        
      },
      processors: [:cropper],
      
      # url: "/system/project_files/:hash.:extension",
      hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
    }
    
    before_post_process :resize_and_init_images
        
    scope :landscape, lambda { where("width > height") }
    scope :portrait, lambda { where("height >= width") }
  end
  
  def meta
    self.read_attribute(:meta) or {}
  end
  
  def image_format
    self.transparent? ? :png : :jpg
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
    
  
    def cropping?
      self.meta and self.meta[:crop] and !self.meta[:crop].empty?
    end

    def square_style(s)
      {geometry: "#{s}x#{s}#",  format: image_format}
    end

    def cinema_style(w)
      h = w / 16 * 9
      { geometry: "#{w}x#{h}#", format: image_format }
    end
  
end