Resque::Mailer.excluded_environments = []

class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
end