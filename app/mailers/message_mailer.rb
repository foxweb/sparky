class MessageMailer < ApplicationMailer
  def new_message(message_data)
    @message_data = message_data

    mail to: 'lesha@kurepin.com'
  end
end
