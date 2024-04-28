require 'sidekiq-scheduler'

class ChatSchedulerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    chats = Chat.all
    chats.each do |chat|
        chat.messages_count = Message.where(chat_number: chat.number,application_token: chat.application_token).count
        chat.save
    end
  end
end