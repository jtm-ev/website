class Event < ActiveRecord::Base
  attr_accessible :description, :end_time, :location, :project_id, :public, :start_time, :title

  belongs_to :project

end
