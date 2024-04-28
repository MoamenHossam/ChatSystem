class ChatCreationService
    def generate_unique_chat_number(application_token)
        chat_next_id = find_or_create_chat_next_id(application_token)
        chat_number = chat_next_id.next_id
        increment_chat_next_id(chat_next_id)
        return chat_number
    end
    
    private
    
    def find_or_create_chat_next_id(application_token)
        ChatNextId.find_or_create_by(token: application_token)
    end
    
    def increment_chat_next_id(chat_next_id)
        chat_next_id.with_lock do
        chat_next_id.next_id += 1
        chat_next_id.save
        end
    end
end