require "rails_helper"

describe SendSlackNotification do
  subject {slack}
  let(:slack) {
    SendSlackNotification.new(message: message)
  }
  let(:message) {
    {
      "RecordType": "Bounce",
      "Type": "SpamNotification",
      "TypeCode": 512,
      "Name": "Spam notification",
      "Tag": "",
      "MessageStream": "outbound",
      "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
      "Email": "zaphod@example.com",
      "From": "notifications@honeybadger.io",
      "BouncedAt": "2023-02-27T21:41:30Z",
    }.transform_keys(&:to_sym)
  }

  # throw out Slack::Web::Api::Errors::InvalidAuth
  # use VCR to do it correctly
  describe '#send_spam_notification', skip: true do
    it 'receives correct arguments' do
      subject.send_spam_notification

      expect_any_instance_of(SendSlackNotification).to receive(:chat_postMessage).with(
        channel: '#spam_notification',
        text: 'adfsa',
        as_user: true
      )
    end
  end
end
