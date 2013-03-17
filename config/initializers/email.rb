
unless Rails.env.test?
  email_config = YAML::load(File.open(Rails.root.join('config/email.yml')))
  env_email_config = email_config[Rails.env] or {}
    
  method = env_email_config[:method]
  if method
    ActionMailer::Base.delivery_method = method
    settings = env_email_config[:settings]
    if settings
      ActionMailer::Base.send "#{method}_settings=".to_sym, settings
    end
  end
end