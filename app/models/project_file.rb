
class ProjectFile < ActiveRecord::Base
  include FileUpload
  include ActivityTrackable
  tracked only: [:create, :destroy]
  
  attr_accessible :kind, :position
  
  belongs_to :project
  
  def press?
    self.kind == 'press'
  end
  
end