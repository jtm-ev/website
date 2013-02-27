class Group < ActiveRecord::Base
  include Navigatable
  
  belongs_to :page, dependent: :destroy, autosave: true
  
  
  accepts_nested_attributes_for :page
  attr_accessible :description, :name, :page_id, :public, :shortcut, :page_attributes
  
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships
  
  # alias :memberships :group_memberships
  liquid_methods :name, :group_memberships, :members
  
  after_initialize :init
  def init
    self.page ||= Page.new
  end
  
  # def memberships
  #   self.group_memberships
  # end
end
