class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('BIGSHOUTZ_EMAIL')
  layout 'mailer'
end
