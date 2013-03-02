class Project < ActiveRecord::Base
  include Navigatable
  
  scope :latest_first, lambda { joins(:events).uniq.order('events.start_time DESC') }
  
  attr_accessible :description, :title, :subtitle, :tag_list, :videos

  has_many :teams, dependent: :destroy
  has_many :team_memberships, through: :teams

  has_many :project_files, dependent: :destroy, order: 'position ASC'
  has_many :events, dependent: :destroy, order: 'start_time ASC'
  has_many :locations, through: :events, uniq: true
  
  acts_as_taggable_on :tags
  
  def ongoing?
    return false unless events.last
    events.last.outstanding?
  end
  
  def year
    return 0 unless events.first
    events.first.start_time.year
  end
  
  def images
    self.project_files.where(kind: 'image')
  end
  
  def image
    images.first
  end
  
  def press
    self.project_files.where(kind: 'press')
  end
  
  def actor_team
    self.teams.where(name: 'Darsteller').first
  end
  
  def non_actor_teams
    self.teams.where("name != 'Darsteller'").sort_by do |a|
      a.has_image? ? 0 : 1
    end
  end
  
end
