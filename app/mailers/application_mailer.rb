class ApplicationMailer < ActionMailer::Base
  default from: ENV['BIGSHOUTZ_EMAIL']
  layout 'mailer'
end
