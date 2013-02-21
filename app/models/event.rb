class Event < ActiveRecord::Base
  attr_accessible :description, :end_time, :location_name, :project_id, :public, :start_time, :title

  belongs_to :project

end
