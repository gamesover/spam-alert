# frozen_string_literal: true

require 'rails_helper'

describe SpamChecker do
  subject { checker }
  let(:checker) do
    SpamChecker.new(message: message)
  end
  let(:message) do
    {
      "RecordType": 'Bounce',
      "Type": 'SpamNotification',
      "TypeCode": 512,
      "Name": 'Spam notification',
      "Tag": '',
      "MessageStream": 'outbound',
      "Description": 'The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.',
      "Email": 'zaphod@example.com',
      "From": 'notifications@honeybadger.io',
      "BouncedAt": '2023-02-27T21:41:30Z'
    }.transform_keys(&:to_sym)
  end

  # throw out Slack::Web::Api::Errors::InvalidAuth
  # use VCR to do it correctly
  describe '#check_and_send_notification' do
    describe 'when is spam' do
      it 'sends slack notification' do
        subject.check_and_send_notification

        expect_any_instance_of(SendSlackNotification).to receive(:send_spam_notification)
      end

      it 'returns true' do
        expect(subject.check_and_send_notification).to be(true)
      end
    end

    describe 'when is not spam' do
      let(:message) do
        {
          "RecordType": 'Bounce',
          "MessageStream": 'outbound',
          "Type": 'HardBounce',
          "TypeCode": 1,
          "Name": 'Hard bounce',
          "Tag": 'Test',
          "Description": 'The server was unable to deliver your message (ex: unknown user, mailbox not found).',
          "Email": 'arthur@example.com',
          "From": 'notifications@honeybadger.io',
          "BouncedAt": '2019-11-05T16:33:54.9070259Z'
        }.transform_keys(&:to_sym)
      end

      it 'returns false' do
        expect(subject.check_and_send_notification).to be(false)
      end
    end
  end
end
