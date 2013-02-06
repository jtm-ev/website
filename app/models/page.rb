class Page < ActiveRecord::Base
  include ActsAsTree
  
  attr_accessible :content, :order, :parent_id, :public, :show_in_navigation, :title
  
  acts_as_tree order: "created_at"
  
end
