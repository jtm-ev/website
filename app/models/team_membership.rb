class TeamMembership < ActiveRecord::Base
  attr_accessible :role, :public, :order, :member_id, :team_id
  
  belongs_to :team
  belongs_to :member
  
  # Könnte Rollen-Foto Enthalten
  
end