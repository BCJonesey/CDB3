# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cdb3::Application.initialize!

Cdb3::Application.configure do
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = {
          :location => "ssmtp",
          :arguments => "-i"
        }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
end
