class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :members, :join_table => :members_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
  
  def to_s
    self.name
  end
end
