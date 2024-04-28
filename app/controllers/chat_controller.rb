class ChatController < ApplicationController

    skip_before_action :verify_authenticity_token


    def index
      begin  
        application = Application.find_by(token: params[:application_token])
        if application
          chats = Chat.where(application_token: params[:application_token]).order(created_at: :asc)
          render json: chats, :except => [:id,:created_at,:updated_at]
        else
          render json: { error: 'Application not found' }, status: :not_found
        end
        rescue StandardError => e
          render json: { error: e.message }, status: :internal_server_error
      end
    end

    def create
      begin
        application = Application.find_by(token: params[:application_token])
        if application
          chat_number = ChatCreationService.new.generate_unique_chat_number(params[:application_token])
          ChatWorker.perform_async(chat_params.to_unsafe_h,params[:application_token],chat_number)
          render json: {'chat_number'=> chat_number}.to_json
        else
          render json: { error: 'Application not found' }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end

    def update
      begin
        application = Application.find_by(token: params[:application_token])
        if application
          chat = Chat.find_by(application_token: params[:application_token],number: params[:number])
          if chat
            if chat.update(chat_params)
              render json: chat
            else
              render json: { error: chat.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { error: 'Chat not found' }, status: :not_found
          end
        else
          render json: { error: 'Application not found' }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end



    private

    def chat_params
      params.require(:chat).permit(:name,:application_token,:number)
    end

end
