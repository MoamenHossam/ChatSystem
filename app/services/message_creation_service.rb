class MessageCreationService

    def generate_unique_message_number(application_token,chat_number)
        message_next_id = find_or_create_message_next_id(application_token,chat_number)
        message_number = message_next_id.next_id
        increment_message_next_id(message_next_id)
        return message_number
    end
    
    private
    
    def find_or_create_message_next_id(application_token,chat_number)
        MessageNextId.find_or_create_by(token: application_token,chat_number: chat_number)
    end
    
    def increment_message_next_id(message_next_id)
        message_next_id.with_lock do
        message_next_id.next_id += 1
        message_next_id.save
        end
    end
end