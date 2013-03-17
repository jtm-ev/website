class TeamMembership < ActiveRecord::Base
  include FileUpload
  
  attr_accessible :role, :public, :position, :member_id, :team_id, :member, :team
  
  belongs_to :team
  belongs_to :member  
  
  def <=>(o)
    return o.team.project.year <=> self.team.project.year
  end
  
  def project
    self.team.project
  end
  
  def actor_image
    return @actor_image if @actor_image
    
    return (@actor_image = self) if self.has_image?
    return (@actor_image = self.member) if self.member and self.member.has_image?
    return nil
  end
  
  def role_image
    return @role_image if @role_image
    
    return (@role_image = self) if self.has_image?
    return (@role_image = self.project.images.first)
  end
  
end