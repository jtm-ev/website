
class GroupMembership < ActiveRecord::Base
  attr_accessible :role, :member_id, :group_id, :member, :group
  
  belongs_to :member
  belongs_to :group
  
end