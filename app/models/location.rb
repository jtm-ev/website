class Location < ActiveRecord::Base
  include Navigatable
  
  attr_accessible :address, :latitude, :longitude, :name, :page_id
  geocoded_by :joined_address
  
  after_validation :geocode #, if: :address_changed?
  
  before_save :ensure_page
  
  belongs_to :page, dependent: :destroy
  has_many :events
  has_many :projects, through: :events, uniq: true
  
  delegate :image, to: :page
  
  def joined_address
    return '' if address.nil?
    address.lines.map{|l| l.strip }.join(', ')
  end
  
  def ensure_page
    self.page = Page.category('Locations').children.create(title: name) if self.page.nil?
  end
  
end
