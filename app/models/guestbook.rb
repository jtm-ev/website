class Guestbook < ActiveRecord::Base
  # attr_accessible :content, :email, :name, :project_id, :website
  belongs_to :project

  validates_presence_of :content
  before_save :sanatize

  def sanatize
    unless self.content.nil?
      self.content = Sanitize.clean(content, Sanitize::Config::RESTRICTED)
      self.content = content.gsub(/\n/, '<br/>')
    end
    self.name = Sanitize.clean(name) unless self.name.nil?
  end
end
