require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:ok)
    end

    it 'renders JSON with applications data' do
        application = create(:application)
        get :index
        expect(response.body).to include(application.name)
    end

    it 'handles errors gracefully' do
      allow(Application).to receive(:all).and_raise(StandardError, 'Something went wrong')
      get :index
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)).to include('error' => 'Something went wrong')
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { application: { name: 'Test Application' } } }

    it 'creates a new application' do
      expect {
        post :create, params: valid_params
      }.to change(Application, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'renders JSON with the created application data' do
      post :create, params: valid_params
      expect(response.body).to include('Test Application')
    end

    it 'handles validation errors' do
      invalid_params = { application: { worng_name: 'test' } }
      post :create, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'handles errors gracefully' do
      allow(Application).to receive(:new).and_raise(StandardError, 'Something went wrong')
      post :create, params: valid_params
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)).to include('error' => 'Something went wrong')
    end
  end

  describe 'PUT #update' do
    let!(:application) { create(:application) }
    let(:valid_params) { { name: 'Updated Name' } }

    it 'updates an existing application' do
      put :update, params: { token: application.token, application: valid_params }
      application.reload
      expect(application.name).to eq('Updated Name')
      expect(response).to have_http_status(:created)
    end

    it 'handles application not found' do
      put :update, params: { token: 'nonexistent_token', application: valid_params }
      expect(response).to have_http_status(:not_found)
    end



    it 'handles errors gracefully' do
      allow(Application).to receive(:find_by).and_raise(StandardError, 'Something went wrong')
      put :update, params: { token: application.token, application: valid_params }
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)).to include('error' => 'Something went wrong')
    end
  end
end
