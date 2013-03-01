class Team < ActiveRecord::Base
  include FileUpload
    
  attr_accessible :name, :public, :position
  
  belongs_to :project
  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships, uniq: true
  # has_many :events, through: :project

end