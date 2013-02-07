class Team < ActiveRecord::Base
  attr_accessible :name, :public, :order
  
  belongs_to :project
  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships
end