class NotifierJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification_subscription = JSON.parse(notification.user.notification_subscription)
    Webpush.payload_send(
      message: "{\"title\": \"#{notification.title}\", \"body\": \"#{notification.body}\"}",
      endpoint: notification_subscription['endpoint'],
      p256dh: notification_subscription['keys']['p256dh'],
      auth: notification_subscription['keys']['auth'],
      vapid: {
        subject: NOTIFICATIONS['vapid']['subject'],
        public_key: NOTIFICATIONS['vapid']['public_key'],
        private_key: NOTIFICATIONS['vapid']['private_key']
      },
      ssl_timeout: 5,
      open_timeout: 5,
      read_timeout: 5
    )
  end
end
