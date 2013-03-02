class Page < ActiveRecord::Base
  include ActsAsTree
  
  scope :public, lambda { where(public: true) }
  scope :in_navigation, lambda { public.where(show_in_navigation: true) }
  
  default_scope order: 'position'
  
  attr_accessor :color
  attr_accessible :content, :position, :parent_id, :public, :show_in_navigation, :title, :background_id, :background, :navigation_style
  
  acts_as_tree order: "position"
  
  has_many :page_files, dependent: :destroy, order: 'created_at DESC'
  belongs_to :background, class_name: 'PageFile', foreign_key: 'background_id'
  
  liquid_methods :title, :group
  
  def image
    page_files.first
  end
  
  def has_children?
    self.children.length > 0
  end
  
  def root?
    self.parent.nil?
  end
  
  def parents
    p = []
    s = self.parent
    while(s) do
      p << s unless s.root?
      s = s.parent
    end
    p.reverse
  end
  
  def group
    Group.where(page_id: self.id).first
  end
  
  def self.tree_array(pages = nil, indent_str = '---', indent = 0)
    pages ||= roots
    result = []
    pages.each do |page|
      indentation = (indent_str * indent).strip
      result << OpenStruct.new(id: page.id, label: "#{indentation} #{page.title}".strip, level: indent, instance: page)
      result += tree_array(page.children, indent_str, indent + 1)
    end
    result
  end
  
  def self.category(title)
    Page.roots.find_or_create_by_title(title)
  end
  
end
