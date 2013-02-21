# Crop Images using JS: http://mfischer.com/wordpress/2009/02/02/multiple-image-upload-and-crop-with-rails/comment-page-1/

module FileUpload
  extend ActiveSupport::Concern
  
  included do
    attr_accessible :file, :file_fingerprint, :file_meta, :description, :file_file_name, :meta
    serialize :meta, Hash
    
    # Auto-Rotate gibt bei manchen Bildern Probleme (EXIF autoorient?): http://pjkh.com/articles/rails-paperclip-auto-orient-and-resizing/
    # https://github.com/thoughtbot/paperclip/wiki/Interpolations
    has_attached_file :file, {
      # default_options: {
      #   auto_orient: false
      # },
      # auto_orient: false,
      # styles: {
      #   square: {geometry: '100x100#', format: :png}, #, auto_orient: true, orient: 'top-left'
      #   # thumb:  {geometry: '120x120', format: :png},
      #   # medium: {geometry: '540x540', format: :png},
      #   # large:  {geometry: '1024x1024', format: :png},
      #   # large_cinema: {geometry: '1024x576^', format: :png}  #16:9
      #   large_cinema: lambda { |instance|
      #     if instance.landscape?
      #       {
      #         geometry: '1024x576#', format: :png
      #       }
      #     else
      #       {
      #         geometry: '1024x', format: :png, convert_options: '+repage -crop 1024x576+0+0 -gravity North'
      #       }
      #     end
      #   }
      #   # large_photo: {geometry: '1024x768#', format: :png}    #4:3
      # },
      styles: lambda { |asset|
        lc_style = { geometry: '1024x576#', format: :png }
        # unless asset.instance.landscape?
        #   lc_style = { geometry: '1024x', format: :png, convert_options: '+repage -crop 1024x576+0+100 -gravity North' }
        # end
        {
          square: {geometry: '100x100#', format: :png},
          square_300: {geometry: '300x300#', format: :png},
          large:  {geometry: '1024x', format: :png},
          large_cinema: lc_style
        }
      },
      convert_options: {
        # all: '-auto-orient '
        # all: '-orient top-left'
        # large_cinema: '-gravity North'
      #   # square: "-quality 75 -strip",
      #   # thumb:  "-quality 75 -strip",
      #   # large:  "-quality 100 -strip"  
      },
      url: "/system/project_files/:hash.:extension",
      hash_secret: "207ff786710bf9b55b4481b393cff8be9a64a96088cface4b4ab7cf648cd01d8222030def29bbc52b284e4327c73b97d4e45468e676"
    }
    
    before_post_process :resize_and_init_images
        
    scope :landscape, lambda { where("width > height") }
    scope :portrait, lambda { where("height >= width") }
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