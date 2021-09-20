class ApplicationMailer < ActionMailer::Base
  default from: 'postmaster@mg.tradesmen.io'
  layout 'mailer'
end
