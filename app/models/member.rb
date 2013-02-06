class Member < ActiveRecord::Base
  attr_accessible :active, :birth_name, :birthday, :city, :email, :email_extern, :fax, :first_name, :gender, :member_since, :mobile, :name, :phone, :school, :street

  has_many :team_members
  has_many :teams, through: :team_members
  has_many :projects, through: :teams, uniq: true

  def full_name
    [self.name, self.first_name].join ' '
  end

end
