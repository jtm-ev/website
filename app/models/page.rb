class Page < ActiveRecord::Base
  include ActsAsTree
  
  attr_accessor :color
  attr_accessible :content, :position, :parent_id, :public, :show_in_navigation, :title, :background_id, :background, :navigation_style
  
  acts_as_tree order: "position"
  
  has_many :page_files, dependent: :destroy, order: 'created_at DESC'
  belongs_to :background, class_name: 'PageFile', foreign_key: 'background_id'
  
  liquid_methods :title, :group
  
  def has_children?
    self.children.length > 0
  end
  
  def parents
    p = []
    s = self.parent
    while(s) do
      p << s
      s = s.parent
    end
    p
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
  
end
