class Project < ActiveRecord::Base
  include Navigatable


  scope :latest_first, lambda {
    joins(:events).uniq.order('events.start_time DESC')
  }


  has_many :teams, dependent: :destroy #, order: 'name'
  has_many :team_memberships, through: :teams

  has_many :project_files, dependent: :destroy #, order: 'position ASC'
  has_many :events, dependent: :destroy #, order: 'start_time ASC'
  has_many :locations, -> {uniq}, through: :events

  acts_as_taggable_on :tags

  def date
    self.events.first.try(:start_time) or Time.now
  end

  def self.search(page, search, per_page = 10)
    latest_first.where("projects.title LIKE (:name)", {:name => "%#{search}%"}).paginate(page: page, per_page: per_page)
  end

  def ongoing?
    return false unless events.last
    events.last.outstanding?
  end

  def year
    return nil unless events.first
    events.first.start_time.year
  end

  def images
    self.project_files.where(kind: 'image')
  end

  def image
    images.first
  end

  def has_image?
    self.image != nil
  end

  def press
    self.project_files.where(kind: 'press')
  end

  def actor_teams
    self.teams.where(name: 'Darsteller')
  end

  def non_actor_teams
    self.teams.where("name != 'Darsteller'").sort_by do |a|
      a.has_image? ? 0 : 1
    end
  end

  def cover
    @cover ||= self.images.first
  end

end
