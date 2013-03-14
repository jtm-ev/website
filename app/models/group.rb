class Group < ActiveRecord::Base
  include Navigatable
  resourcify
  
  scope :public, lambda { where(public: true) }
  
  belongs_to :page, dependent: :destroy, autosave: true
  
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :page
  attr_accessible :description, :name, :page_id, :public, :shortcut, :page_attributes, :category
  
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
    self.page = Page.category('Groups').children.find_or_create_by_title(name) if self.page.nil?
  end
  
  def has_page?
    page and page.is_public? and not page.content.blank?
  end
  
  def image
    page and page.image
  end
  
  def has_image?
    page and page.has_image?
  end
  
end
