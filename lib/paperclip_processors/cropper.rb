module Paperclip
  class Cropper < Thumbnail
    def plus_helper(i)
      if i < 0
        "#{i}"
      else
        "+#{i}"
      end
    end
    
    def transformation_command
      if true #crop_command
        cmd = super
        Rails.logger.info "\n ORG: #{cmd.inspect}\n"
        
        i = @attachment.instance
        crop_meta = i.meta[:crop]
        
        return cmd if crop_meta.nil? or crop_meta[:square].blank? or crop_meta[:cinema].blank?
        
        crop_index = cmd.index('-crop')
        unless crop_index.nil?
          new_crop = (cmd[ crop_index + 1].gsub /(\d*)x(\d*)\+(\d*)\+(\d*)/ do |s|
            Rails.logger.info "\n Image: #{i.inspect}"
            square = ($1 == $2)
            oX = oY = 0
            
            if square
              d = crop_meta[:square]
            else
              d = crop_meta[:cinema]
            end
            
            x = d['x'].to_i
            y = d['y'].to_i
            
            Rails.logger.info "GSUB: #{$1} | #{$2} | #{$3} | #{$4}"
            
            if i.portrait?            
              Rails.logger.info "------ Portrait"
              ratio = $1.to_f / i.width.to_f
            else
              Rails.logger.info "------ Landscape"
              ratio = $1.to_f / i.height.to_f
              
              # oX = (x.to_f / i.height.to_f * $1.to_f).to_i
              # oY = (ratio * y).to_i
            end

            oX = (ratio * x).to_i
            oY = (ratio * y).to_i                            
            
            
            Rails.logger.info "\n INFO: #{$1.to_i} / #{i.width} * #{y} = #{oY}"
            Rails.logger.info " INFO: #{$1.to_i} / #{i.height} * #{x} = #{oX} : r= #{ratio} \n"
            
            # Rails.logger.info "\n Replace: #{d.inspect} \n"
            
            "#{$1}x#{$2}#{plus_helper(oX)}#{plus_helper(oY)}"
          end)
          Rails.logger.info "\n DO CROP: #{new_crop} \n"
          cmd[ crop_index + 1 ]  = new_crop
          
          cmd.shift
          Rails.logger.info "UNSHIFTED: #{cmd.inspect}"
        end
        # cmd = crop_command + super.sub(/ -crop \S+/, '')
        # Rails.logger.info "\n MOD: #{cmd.inspect}\n"
        cmd
      else
        super
      end
    end

    # def crop_command
    #   target = @attachment.instance
    #   if target.cropping?
    #     crop_w = 100
    #     crop_h = 100
    #     crop_x = 0
    #     crop_y = 0
    #     "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    #   end
    # end
  end
end