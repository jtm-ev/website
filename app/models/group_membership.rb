
class GroupMembership < ActiveRecord::Base
  # attr_accessible :role, :member_id, :group_id, :member, :group, :position

  belongs_to :member
  belongs_to :group

  liquid_methods :role, :member

  validates_presence_of :member

  before_create do
    self.position = (self.group.group_memberships.count + 1) unless self.group.nil?
  end

end
