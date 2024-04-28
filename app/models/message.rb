class Message < ApplicationRecord
    searchkick
    after_create :reindex_messages


    private 
    def reindex_messages
        Message.reindex
    end
end
