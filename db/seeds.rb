# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
["app1", "app2", "app3", "app4"].each do |app_name|
    Application.find_or_create_by!(name: app_name,token: Application.new.generate_token)
  end


  ["chat1", "chat2", "chat3", "chat4"].each do |chat_name|
    token = Application.first.token
    Chat.find_or_create_by!(name: chat_name,application_token: token,number:  ChatCreationService.new.generate_unique_chat_number(Application.first.token))
  end

  ["message body 1", "message body 1", "message body 1", "message body 1"].each do |message|
    token = Application.first.token
    chat_number = Chat.find_by(application_token: token).number
    message_number = MessageCreationService.new.generate_unique_message_number(token,chat_number)
    Message.find_or_create_by!(body: message,application_token: token,chat_number: chat_number,message_number: message_number)
  end
