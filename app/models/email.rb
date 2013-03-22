class Email < ActiveRecord::Base
  attr_accessible :addresses, :content, :subject
end
