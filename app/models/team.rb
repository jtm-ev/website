class Team < ActiveRecord::Base
  include FileUpload
  include Navigatable
  include ActivityTrackable
  tracked
  
  attr_accessible :name, :public, :position
  
  belongs_to :project
  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships, uniq: true, order: 'name, first_name'
  # has_many :events, through: :project
  
  delegate :year, to: :project

  def ordered_team_memberships
    self.team_memberships.joins(:member).order('members.name, members.first_name')
  end
  
  def size
    team_memberships.length
  end

end