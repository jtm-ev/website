
class GroupMembership < ActiveRecord::Base
  attr_accessible :role, :member_id, :group_id, :member, :group, :position
  
  belongs_to :member
  belongs_to :group
  
  liquid_methods :role, :member
  
end