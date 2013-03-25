module ActivityTrackable
  extend ActiveSupport::Concern
  
  included do
    include PublicActivity::Model
    
    def self.tracked(opts = {})
      opts[:owner] ||= ->(controller, model) { controller && controller.current_user }
      super(opts)
    end
  end
  
end