class TeamMembership < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :role, :public, :position, :member_id, :team_id
  
  belongs_to :team
  belongs_to :member
  
  
  def actor_image
    return @actor_image if @actor_image
    
    return (@actor_image = self.file) if self.has_image?
    return (@actor_image = self.member.file) if self.member and self.member.has_image?
    return nil
  end
  
end