class Project < ActiveRecord::Base
  scope :previous,  lambda { |i| {conditions: ["#{self.table_name}.id > ?", i.id]} }
  scope :next,      lambda { |i| {conditions: ["#{self.table_name}.id < ?", i.id]} }
  scope :latest_first,  lambda { order('id DESC') }
  
  # default_scope scoped
  # scope :previous,  lambda { |i| where('id < ?', i.id).first }
  # scope :next,      lambda { |i| where('id > ?', i.id).first }
  
  attr_accessible :description, :title, :subtitle, :tag_list, :videos

  has_many :teams, dependent: :destroy
  has_many :team_memberships, through: :teams

  has_many :project_files, dependent: :destroy, order: 'position ASC'
  has_many :events, dependent: :destroy, order: 'start_time ASC'
  
  acts_as_taggable_on :tags
  
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
  
  def actor_team
    self.teams.where(name: 'Darsteller').first
  end
  
  def non_actor_teams
    self.teams.where("name != 'Darsteller'")
  end
  
end
