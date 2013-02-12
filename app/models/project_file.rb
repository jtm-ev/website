
class ProjectFile < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :kind
  
  belongs_to :project
  
end