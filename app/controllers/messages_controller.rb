class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.save

    render json: message, status: :created
  end

  def index
    render json: Message.all
  end

private
  def message_params
    params.require(:message).permit(:name, :email, :phone, :body)
  end
end
