class ApplicationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        begin
            applications = Application.all

            render json: applications, :except => [:id,:created_at,:updated_at],status: :ok
        rescue StandardError => e
            render json: { error: e.message }, status: :internal_server_error
        end
    end


    def create
        begin
            application = Application.new(application_params)
            
            if application.save
                render json: application, :except => [:id,:created_at,:updated_at] , status: :created
            else
                render json: application.errors, status: :unprocessable_entity
        
            end
        rescue StandardError => e
            render json: { error: e.message }, status: :internal_server_error
        end
    end

    def update
        begin
            application = Application.find_by(token: params[:token])
            if application
                application.update(application_params)
                render json: application, :except => [:id,:created_at,:updated_at] , status: :created
            else
                render json: { error: 'Application not found' }, status: :not_found
            end

        rescue StandardError => e
            render json: { error: e.message }, status: :internal_server_error
        end
    end

    private
    
    def application_params
        params.require(:application).permit(:name,:application_token)
    end
end
