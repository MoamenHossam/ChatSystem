# README

* Only need to run docker-compose up to start the application

* Application starts 5 servicess (api-rubyonrails, database(mysql),redis , elasticsearch and sidekiq)

* Onstartup the application will run rails db:prepare which will run the migration and seed.

* The creation of messages and chat are Async operations, using redis queues and sidekiq-workers, but the returning of chat number and message number are still Atomic using version and locking the database records while generating these number to handle race conditions.

* The search messages endpoint will use elasticSearch to search in the messages table but will return only the messages if it belongs to the application token and the chat number sent in the same request.

* Using sidedkiq-scheduler gem to run a scheduled job every 30 minutes that will calculate all the chats_count for application table records and messages_count for chat table records, this job runs in the backend with workers.

* Specs that covers the controllers, routing and model validations.

* Exceptions handling.

*   application End-Points:
    GET    /applications                applications#index
    POST    /applications               applications#create //{"application":{"name":"newApplication"}}
    PUT   /applications/:token         applications#update  //{"application":{"name":"newApplication"}}


    GET    /applications/:application_token/chat                            chat#index
    POST   /applications/:application_token/chat                            chat#create //{"chat":{"name":"newChat"}}
    PUT    /applications/:application_token/chat/:number                    chat#update //{"chat":{"name":"newChat"}}

    GET    /applications/:application_token/chat/:chat_number/messages                    messages#index
    POST   /applications/:application_token/chat/:chat_number/messages                    messages#create//{"message":{"body":"newMessage"}   }
    PUT    /applications/:application_token/chat/:chat_number/messages/:number            messages#update//{"message":{"body":"newMessage"}   }
    GET    /applications/:application_token/chat/:chat_number/messages/search             messages#search
                              