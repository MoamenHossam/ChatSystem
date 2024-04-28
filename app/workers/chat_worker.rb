class ChatWorker 
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(chat_params,application_token,chat_number)
        chat = Chat.new(chat_params)
        chat.application_token=application_token
        chat.number = chat_number
        chat.save
        puts "done with chat number #{chat.number}"
    end

end    