class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound , with: :erorrs_handeler


private
def erorrs_handeler(e)
  render json:{"errors":e}, status: :not_found
end
end
