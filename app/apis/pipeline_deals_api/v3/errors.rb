# frozen_string_literal: true

module PipelineDealsAPI
  module V3
    # Namespace used to encapsulate all the internal errors
    module Errors
      # Base class for all the internal errors
      PipelineDealsAPIError = Class.new(StandardError)
      UnauthorizedError = Class.new(PipelineDealsAPIError)
      BadRequestError = Class.new(PipelineDealsAPIError)
      ForbiddenError = Class.new(PipelineDealsAPIError)
      NotFoundError = Class.new(PipelineDealsAPIError)
      UnprocessableEntityError = Class.new(PipelineDealsAPIError)
      TooManyRequestsError = Class.new(PipelineDealsAPIError)
      ApiError = Class.new(PipelineDealsAPIError)
    end
  end
end
