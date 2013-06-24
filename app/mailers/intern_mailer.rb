class InternMailer < ActionMailer::Base
  default from: "website@jtm.de"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.intern_mailer.email.subject
  #
  def email(user, receips, sub, content)
    @content = content
    
    mail to: receips, from: user.member.email_with_name, subject: sub
  end
end
