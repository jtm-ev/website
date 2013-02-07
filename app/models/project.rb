class Project < ActiveRecord::Base
  attr_accessible :description, :title, :subtitle
  
  has_many :project_files, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :team_memberships, through: :teams
  
  def images
    self.project_files.where(kind: 'image')
  end
  
  def press
    self.project_files.where(kind: 'press')
  end
  
  def team_memberships_for(member)
    self.team_memberships.where(member_id: member.id)
  end
  alias :team_memberships_of :team_memberships_for 
  
end
