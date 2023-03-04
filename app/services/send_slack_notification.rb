# frozen_string_literal: true

class SendSlackNotification
  SPAM_CHANNEL = '#spam_notification'

  def initialize(message:)
    self.message = message
    self.client = Slack::Web::Client.new
  end

  def send_spam_notification
    notification_text = <<-HEREDOC
      Spam message from #{message[:Email]}:
      #{message}
    HEREDOC

    client.chat_postMessage(channel: SPAM_CHANNEL, text: notification_text, as_user: true)
  end

  private

  attr_accessor :message, :client
end
