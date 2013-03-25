
class ProjectFile < ActiveRecord::Base
  include FileUpload
  include ActivityTrackable
  
  attr_accessible :kind, :position
  
  belongs_to :project
  
end