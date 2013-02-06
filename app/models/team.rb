class Team < ActiveRecord::Base
  attr_accessible :name, :public, :order
  
  belongs_to :project
  has_many :team_members, dependent: :destroy
  
end