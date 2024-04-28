class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound , with: :not_found_error_handeler
    rescue_from StandardError ,with: :internal_error_handeler


    private
    def not_found_error_handeler(e)
        render json:{"errors":e}, status: :not_found
    end

    def internal_error_handeler(e)
        render json:{"errors":e}, status: :internal_server_error
    end

end
