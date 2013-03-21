
if Rails.env.development?
  class MailPreview < MailView
    def confirmation
      Devise::Mailer.confirmation_instructions(User.first)
    end
    
    def intern
      # InternMailer.email
    end
  end
end