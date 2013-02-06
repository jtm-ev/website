class Group < ActiveRecord::Base
  belongs_to :page, dependent: :destroy, autosave: true
  
  
  accepts_nested_attributes_for :page
  attr_accessible :description, :name, :page_id, :public, :shortcut, :page_attributes
  
  
  
  after_initialize :init
  def init
    self.page ||= Page.new
  end
end
