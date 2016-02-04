class User < ActiveRecord::Base


  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, ,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :username, :password, :password_confirmation, :remember_me, :member_id, :role_ids

  belongs_to :member

  delegate :full_name, to: :member

  validates_presence_of :member

  before_validation do
    self.member = Member.where(email: "#{self.username}@jtm.de").first
    self.email = self.member.email if self.member
  end

  def groups
    [member.groups, member.leaded_groups].flatten.uniq
  end

end
