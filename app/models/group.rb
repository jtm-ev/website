class Group < ActiveRecord::Base
  include Navigatable
  
  # resourcify #https://github.com/EppO/rolify/wiki/Tutorial
  
  belongs_to :page, dependent: :destroy, autosave: true
  
  
  accepts_nested_attributes_for :page
  attr_accessible :description, :name, :page_id, :public, :shortcut, :page_attributes
  
  has_many :group_memberships, dependent: :destroy, order: 'position'
  has_many :members, through: :group_memberships
  
  # alias :memberships :group_memberships
  liquid_methods :name, :group_memberships, :members
  
  before_save :ensure_page
  
  # after_initialize :init
  # def init
  #   self.page ||= Page.new
  # end
  
  # def memberships
  #   self.group_memberships
  # end
  
  def ensure_page
    self.page = Page.category('Groups').children.create(title: name) if self.page.nil?
  end
end
