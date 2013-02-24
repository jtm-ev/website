class TeamMembership < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :role, :public, :position, :member_id, :team_id
  
  belongs_to :team
  belongs_to :member
    
end