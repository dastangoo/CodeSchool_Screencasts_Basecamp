require 'notification_mailer'

# New Message Job
class NewMessageJob
  include SuckerPunch::Job
  
  # Class Method
  def self.async_perform_each(message)
    emails = message.subscribers.map(&:email)
    emails.each do |email|
      new.async.perform(message, email).deliver
    end
  end
  def perform(message, email)
  end
end