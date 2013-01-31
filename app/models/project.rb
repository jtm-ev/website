class Project < ActiveRecord::Base
  attr_accessible :description, :genre, :title, :year
end
