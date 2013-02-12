
class PageFile < ActiveRecord::Base
  include FileUpload
  
  belongs_to :page
  
end