
if Rails.env.development?
  class MailPreview < MailView
    def confirmation
      Devise::Mailer.confirmation_instructions(User.first)
    end
    
    def intern
      InternMailer.email(User.where(username: 'f.guenther').first, '', 'Test Subject', 'Test Content')
    end
  end
end