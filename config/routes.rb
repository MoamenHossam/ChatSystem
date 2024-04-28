Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/create'

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  


  resources :applications, param: :token do
    resources :chat, param: :number do
      resources :messages, param: :number, only: [:index,:create,:update] do
        collection do
          get 'search'
        end
      end
    end
  end

  # get 'applications/:application_token/chat/:chat_number/messages/:term', to: 'messages#search'


end
