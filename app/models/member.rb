class Member < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :active, :birth_name, :birthday, :city, :email, :email_extern, :fax, :first_name, :gender, :member_since, :mobile, :name, :phone, :school, :street

  scope :active, lambda { where(active: true) }

  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :projects, through: :teams, uniq: true

  liquid_methods :name, :first_name, :full_name

  def full_name
    [self.first_name, self.name].join ' '
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def actor_team_memberships
    team_memberships.joins(:team).where('teams.name = ?', 'Darsteller')
  end
  
  def non_actor_team_memberships
    team_memberships.joins(:team).where('teams.name != ?', 'Darsteller')
  end
  
  
end

