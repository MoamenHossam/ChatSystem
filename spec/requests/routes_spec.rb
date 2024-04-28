require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
    
  describe 'Applications routes' do
    it 'routes to applications#index' do
      expect(get: '/applications').to route_to('applications#index')
    end

    it 'routes to applications#create' do
      expect(post: '/applications').to route_to('applications#create')
    end

    it 'routes to applications#update' do
      expect(put: '/applications/123').to route_to('applications#update', token: '123')
    end

    it 'routes to applications#destroy' do
      expect(delete: '/applications/123').to route_to('applications#destroy', token: '123')
    end
    end



    describe 'Chat routes' do
      it 'routes to chat#index' do
        expect(get: '/applications/123/chat').to route_to('chat#index', application_token: '123')
      end

      it 'routes to chat#create' do
        expect(post: '/applications/123/chat').to route_to('chat#create', application_token: '123')
      end
      it 'routes to chat#update' do
      expect(put: '/applications/123/chat/456').to route_to('chat#update', application_token: '123',number: '456')
      end
    end




    describe 'Message routes' do
        it 'routes to messages#index' do
            expect(get: '/applications/123/chat/456/messages').to route_to('messages#index', application_token: '123', chat_number: '456')
        end

        it 'routes to messages#create' do
            expect(post: '/applications/123/chat/456/messages').to route_to('messages#create', application_token: '123', chat_number: '456')
        end

        it 'routes to messages#update' do
            expect(put: '/applications/123/chat/456/messages/789').to route_to('messages#update', application_token: '123', chat_number: '456', number: '789')
        end

        it 'routes to messages#search' do
            expect(get: '/applications/123/chat/456/messages/search').to route_to('messages#search', application_token: '123', chat_number: '456')
        end
    end
end
