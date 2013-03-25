module ActivityTrackable
  extend ActiveSupport::Concern
  
  included do
    include PublicActivity::Model
    tracked owner: ->(controller, model) { controller && controller.current_user }
  end
end