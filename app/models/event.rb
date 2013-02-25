class Event < ActiveRecord::Base
  scope :outstanding, lambda { where('start_time > ? OR end_time > ?', Time.now, Time.now)  }

  attr_accessible :description, :end_time, :location_name, :project_id, :public, :start_time, :title

  belongs_to :project
  
  def title
    if project.nil?
      super
    else
      project.title
    end
  end

end
