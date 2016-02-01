class Event < ActiveRecord::Base

  scope :upcoming, lambda { where('start_time > ? OR end_time > ?', Time.now, Time.now).order(:start_time)  }

  # attr_accessible :description, :end_time, :location_name, :project, :project_id, :public, :start_time, :title
  delegate :year, to: :start_time

  belongs_to :project
  belongs_to :location

  # def title
  #   if project.nil?
  #     super
  #   else
  #     project.title
  #   end
  # end

  def outstanding?
    return end_tim > Time.now if end_time
    return start_time > Time.now if start_time
    false
  end

  def week
    self.start_time.strftime('%W')
  end

  # def year
  #   self.start_time.year
  # end

end
