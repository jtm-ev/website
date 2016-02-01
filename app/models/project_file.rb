
class ProjectFile < ActiveRecord::Base
  include FileUpload

  # attr_accessible :kind, :position

  belongs_to :project

  def press?
    self.kind == 'press'
  end

end
