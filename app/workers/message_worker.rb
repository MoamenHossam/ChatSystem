class MessageWorker 
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(message_params,application_token,chat_number,message_number)
        message = Message.new(message_params)
        message.application_token=application_token
        message.message_number = message_number
        message.chat_number= chat_number
        message.save
        Message.reindex
        puts "done with chat number #{message.message_number}"
    end

end    