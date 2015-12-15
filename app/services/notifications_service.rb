class NotificationsService
  @@client = Slack::Web::Client.new

  def self.send_user_message(uid, message)
    data = @@client.im_open(user: uid)
    @@client.chat_postMessage(channel: data['channel']['id'], text: message, as_user: true)
  end

  def self.send_channel_message(channel, message)
    channel = @@client.channels_list['channels'].detect { |c| c['name'] == channel }
    @@client.chat_postMessage(channel: channel['id'], text: message, as_user: true)
  end
end
