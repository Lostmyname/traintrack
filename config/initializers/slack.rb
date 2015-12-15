Slack.configure do |config|
  config.token = ENV['SLACK_TMP_API_TOKEN'] # @todo: Use OAuth when available
end