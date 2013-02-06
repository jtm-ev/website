class Project < ActiveRecord::Base
  attr_accessible :description, :title, :subtitle
  
  has_many :project_files, dependent: :destroy
  
  def images
    self.project_files.where(kind: 'image')
  end
  
  def press
    self.project_files.where(kind: 'press')
  end
  
end
