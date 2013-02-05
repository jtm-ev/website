class Project < ActiveRecord::Base
  attr_accessible :description, :title, :subtitle
  
  has_many :project_files, dependent: :destroy
  
end
