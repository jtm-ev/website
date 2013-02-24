class Team < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :name, :public, :order
  
  belongs_to :project
  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships
  

  def has_image?
    !self.file_file_name.nil?
  end

end