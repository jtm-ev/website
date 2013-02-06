class TeamMember < ActiveRecord::Base
  attr_accessible :role, :public, :order, :member
  
  belongs_to :team
  belongs_to :member
  
end