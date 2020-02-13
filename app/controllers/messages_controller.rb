class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)

    if message.save
      MessageMailer.new_message(message_params).deliver_now
      render json: message, status: :created
    else
      render json: { errors: ['wrong params'] }, status: :unprocessable_entity
    end
  end

  def index
    render json: Message.all
  end

private
  def message_params
    params.require(:message).permit(:name, :email, :phone, :body)
  end
end
