class Group < ActiveRecord::Base
  include Navigatable
  
  belongs_to :page, dependent: :destroy, autosave: true
  
  
  accepts_nested_attributes_for :page
  attr_accessible :description, :name, :page_id, :public, :shortcut, :page_attributes
  
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships
  
  
  after_initialize :init
  def init
    self.page ||= Page.new
  end
end
