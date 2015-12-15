class NotificationsService
  @@client = Slack::Web::Client.new

  def self.send_message(uid, message)
    data = @@client.im_open(user: uid)
    @@client.chat_postMessage(channel: data['channel']['id'], text: message, as_user: true)
  end
end
