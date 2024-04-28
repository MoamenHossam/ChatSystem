require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET #index' do
    context 'when application is found' do
      let!(:application) { create(:application) }
      let!(:chat1) { create(:chat, application_token: application.token) }
      let!(:chat2) { create(:chat, application_token: application.token) }

      it 'returns a list of chats' do
        get :index, params: { application_token: application.token }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(chat1.name)
        expect(response.body).to include(chat2.name)
      end
    end

    context 'when application is not found' do
      it 'returns a not found error' do
        get :index, params: { application_token: 'invalid_token' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Application not found')
      end
    end

    context 'when an unexpected error occurs' do
      it 'returns an internal server error' do
        allow(Application).to receive(:find_by).and_raise(StandardError, 'Unexpected error')
        get :index, params: { application_token: 'valid_token' }
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Unexpected error')
      end
    end
  end

  describe 'POST #create' do
    let!(:application) { create(:application) }


    context 'when application is not found' do
      it 'returns a not found error' do
        post :create, params: { application_token: 'invalid_token' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Application not found')
      end
    end

    context 'when an unexpected error occurs' do
      it 'returns an internal server error' do
        allow(Application).to receive(:find_by).and_raise(StandardError, 'Unexpected error')
        post :create, params: { application_token: 'valid_token' }
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Unexpected error')
      end
    end
  end

  describe 'PUT #update' do
    let!(:application) { create(:application) }
    let!(:chat) { create(:chat, application_token: application.token) }

    context 'when chat is found' do
      it 'updates the chat' do
        put :update, params: { application_token: application.token, number: chat.number, chat: { name: 'Updated Name' } }
        expect(response).to have_http_status(:ok)
        chat.reload
        expect(chat.name).to eq('Updated Name')
      end
    end

    context 'when chat is not found' do
      it 'returns a not found error' do
        put :update, params: { application_token: application.token, number: 'invalid_number', chat: { name: 'Updated Name' } }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Chat not found')
      end
    end

    context 'when an unexpected error occurs' do
      it 'returns an internal server error' do
        allow(Chat).to receive(:find_by).and_raise(StandardError, 'Unexpected error')
        put :update, params: { application_token: application.token, number: chat.number, chat: { name: 'Updated Name' } }
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Unexpected error')
      end
    end
  end
end
