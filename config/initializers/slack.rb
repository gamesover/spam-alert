Slack::Web::Client.configure do |config|
  config.user_agent = 'Slack Ruby Client/1.0'
  config.token = ENV['SLACK_TOKEN']
end
