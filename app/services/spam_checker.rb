# frozen_string_literal: true

class SpamChecker
  SPAM_TYPECODE = 512

  def initialize(message:)
    self.message = message
  end

  def check_and_send_notification
    if spam_message?
      SendSlackNotification.new(message: message).send_spam_notification
      true
    else
      false
    end
  end

  private

  attr_accessor :message

  def spam_message?
    message[:TypeCode] == SPAM_TYPECODE
  end
end
