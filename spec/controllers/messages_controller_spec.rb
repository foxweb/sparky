require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  context 'with valid params' do
    let(:message_params) do
      {
        name:  'John Smith',
        email: 'john@example.com',
        phone: 78_901_234_567,
        body:  'Hello World!'
      }
    end

    it 'creates a new Message' do
      expect {
        post :create, params: { message: message_params }
      }.to change { Message.count }

      message = Message.last
      expect(message.name).to  eq(message_params[:name])
      expect(message.email).to eq(message_params[:email])
      expect(message.phone).to eq(message_params[:phone])
      expect(message.body).to  eq(message_params[:body])
    end

    it 'renders 201 Created' do
      post :create, params: { message: message_params }
      expect(response).to have_http_status(:created)
    end
  end
end
