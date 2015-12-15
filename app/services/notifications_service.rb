class NotificationsService
  def initialize
    @client = Slack::Web::Client.new
  end

  def send_message(uid, message)
    data = @client.im_open(user: uid)
    @client.chat_postMessage(channel: data['channel']['id'], text: message, as_user: true)
  end
end
