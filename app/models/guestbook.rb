class Guestbook < ActiveRecord::Base
  attr_accessible :content, :email, :name, :project_id, :website
  belongs_to :project
end
