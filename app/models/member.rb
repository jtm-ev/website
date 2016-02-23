class Member < ActiveRecord::Base
  include FileUpload
  include Navigatable

  rolify

  # attr_accessible :active, :birth_name, :birthday, :city, :email, :email_extern, :fax, :first_name, :gender, :member_since, :mobile, :name, :phone, :school, :street

  scope :active, lambda { where(active: true) }
  scope :inactive, lambda { where(active: false) }
  scope :with_birthday_in, lambda { |month| where(birth_month: month).order(:birth_month, :birth_day) }
  scope :ordered, lambda { order(:name, :first_name) }

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :projects, through: :teams #, uniq: true

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_one :user

  liquid_methods :name, :first_name, :full_name

  before_save do
    if self.birthday
      self.birth_month  = self.birthday.month
      self.birth_day    = self.birthday.day
    end
  end

  def full_name
    [self.first_name, self.name].join ' '
  end

  def ordered_full_name
    [self.name, self.first_name].join ' '
  end

  def age
    return nil if birthday.nil?
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def email_with_name
    email.blank? ? nil : "#{email}" #"#{full_name}<#{email}>"
  end

  def actor_team_memberships
    team_memberships.joins(:team).where('teams.name = ?', 'Darsteller').sort
  end

  def non_actor_team_memberships
    team_memberships.joins(:team).where('teams.name != ?', 'Darsteller')
  end

  def hdk_memberships_with_image
    non_actor_team_memberships.select do |tms|
      tms.team.has_image?
    end
  end

  def hdk_memberships_without_image
    non_actor_team_memberships.reject { |tms|
      tms.team.has_image?
    }.group_by(&:team_name)
  end

  def hdk_memberships
    non_actor_team_memberships.group_by do |tms|
      tms.team.name
    end
  end

  def leaded_groups
    Group.with_role(:group_leader, self)
  end

  def male?
    self.gender == 'm'
  end

  def female?
    self.gender == 'w'
  end

  def deactivate
    self.update_attributes(active: false)
    self.group_memberships.delete_all
    self.user.try(:destroy)
    # TODO: send email to admin to delete usere internal email address
  end

  def activate
    self.update_attributes(active: true)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |member|
        csv << member.attributes.values_at(*column_names)
      end
    end
  end


end
