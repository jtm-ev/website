class Project < ActiveRecord::Base
  attr_accessible :description, :title, :subtitle, :tag_list
  
  has_many :project_files, dependent: :destroy
  
  acts_as_taggable_on :tags
  
  def images
    self.project_files.where(kind: 'image')
  end
  
  def press
    self.project_files.where(kind: 'press')
  end
  
end
