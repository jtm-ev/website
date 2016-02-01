class Email < ActiveRecord::Base
  # attr_accessible :to, :content, :subject
  serialize :to, Array
end
