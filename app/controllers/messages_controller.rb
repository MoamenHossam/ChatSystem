class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    chat = Chat.find_by!(application_token: params[:application_token],number: params[:chat_number])
    if chat
      messages = Message.where(application_token: params[:application_token] ,chat_number: params[:chat_number]).order(created_at: :asc)
      render json: messages, :except => [:id,:created_at,:updated_at]
    else
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  def create
      chat = Chat.find_by(application_token: params[:application_token],number: params[:chat_number])
      if chat
        message_number=MessageCreationService.new.generate_unique_message_number(params[:application_token],params[:chat_number])
        MessageWorker.perform_async(message_params.to_unsafe_h,params[:application_token],params[:chat_number],message_number)
        render json: {'message_number'=> message_number}.to_json
      else
        render json: { error: 'Chat not found' }, status: :not_found
      end
  end


  def update
    chat = Chat.find_by(application_token: params[:application_token],number: params[:chat_number])
    if chat
      message = Message.find_by(application_token: params[:application_token], chat_number: params[:chat_number], message_number: params[:number])
      if message
        if message.update(message_params)
          render json: message
        else
          render json: { error: message.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'message not found' }, status: :not_found
      end
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def search
    messages = Message.search(params[:term]).where(application_token: params[:application_token],chat_number: params[:chat_number])
    matched_msgs = messages.map{|msg| msg }
    render json: matched_msgs, :except => [:id,:created_at,:updated_at]
  end



  private
    def message_params
      params.require(:message).permit(:body,:application_token,:chat_number,:message_number)
    end

end
