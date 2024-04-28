require 'rails_helper'

RSpec.describe "ChatControllers", type: :request do
  describe "GET /index" do
    let(:headers) do
      { 'ACCEPT' => 'application/json', 'Content-Type' => 'application/json' }
    end
    it "should retrive chat in chats table - checking count" do
      get "/applications" , headers: headers , as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body[0]['name']).to eq("updated3")
    end
  end
end
