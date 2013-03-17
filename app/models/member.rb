class Member < ActiveRecord::Base
  include FileUpload
  include Navigatable
  
  rolify
  
  attr_accessible :active, :birth_name, :birthday, :city, :email, :email_extern, :fax, :first_name, :gender, :member_since, :mobile, :name, :phone, :school, :street

  scope :active, lambda { where(active: true) }
  scope :inactive, lambda { where(active: false) }

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :projects, through: :teams, uniq: true
  
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  liquid_methods :name, :first_name, :full_name

  def full_name
    [self.first_name, self.name].join ' '
  end

  def age
    return nil if birthday.nil?
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def actor_team_memberships
    team_memberships.joins(:team).where('teams.name = ?', 'Darsteller').sort
     # do |t2, t1|
     #      t1.team.project.year <=> t2.team.project.year
     #    end
  end
  
  def non_actor_team_memberships
    team_memberships.joins(:team).where('teams.name != ?', 'Darsteller').sort.sort_by do |t|
      t.team.has_image? ? 0 : 1
    end
  end
  
  
end

