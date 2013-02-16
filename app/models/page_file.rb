
class PageFile < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :position
  
  belongs_to :page
  
end