class ApplicationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
    applications = Application.all

    render json: applications, :except => [:id,:created_at,:updated_at],status: :ok
    end


    def create
        application = Application.new(application_params)
        
        if application.save
            # ChatNextId.create(token: application.token)
            render json: application, :except => [:id,:created_at,:updated_at] , status: :created
        else
            render json: application.errors, status: :unprocessable_entity
    
        end
    end

    def update
        application = Application.find_by!(token: params[:token])
        # if application
            application.update(application_params)
            render json: application, :except => [:id,:created_at,:updated_at] , status: :created
        # else
        #     render json: { error: 'Application not found' }, status: :not_found
        # end
        # rescue
        #     render json: { error: 'Application not found' }, status: :not_found
    end

    private
    
    def application_params
        params.require(:application).permit(:name,:application_token)
    end
end
