class ErrorsController < ApplicationController
  def not_found
    Rails.logger.info request.host
    raise ActionController::RoutingError,
      "No route matches #{request.path.inspect}"
  end
end
