# frozen_string_literal: true

require 'net/http'
require 'oj'

# require_relative 'errors'

module PipelineDealsAPI
  module V3
    class Client
      API_ENDPOINT = 'https://api.pipelinedeals.com/api/v3/%s.json'

      attr_reader :api_key

      def initialize(api_key:)
        @api_key = api_key
      end

      def deals
        deals_url = url('deals', params)
        response = request(deals_url)
        parse(response)
      end

      private

      def parse(response)
        return Oj.load(response.body) if response_successful?(response.code.to_i)

        raise error_class(response.code.to_i)
      end

      def request(url)
        Net::HTTP.get_response(url)
      end

      def params
        {
          api_key: api_key
        }
      end

      def url(api_name, params)
        uri = URI(format(API_ENDPOINT, api_name))
        uri.query = URI.encode_www_form(params)
        uri
      end

      def response_successful?(code)
        code == HTTPStatusCodes::HTTP_OK
      end

      def error_class(code)
        case code
        when HTTPStatusCodes::HTTP_UNAUTHORIZED
          Errors::UnauthorizedError
        when HTTPStatusCodes::HTTP_FORBIDDEN
          Errors::ForbiddenError
        when HTTPStatusCodes::HTTP_NOT_FOUND
          Errors::NotFoundError
        when HTTPStatusCodes::HTTP_UNPROCESSABLE_ENTITY
          Errors::UnprocessableEntityError
        when HTTPStatusCodes::HTTP_TOO_MANY_REQUESTS
          Errors::TooManyRequestsError
        when HTTPStatusCodes::HTTP_BAD_REQUEST
          Errors::BadRequestError
        else
          Errors::ApiError
        end
      end
    end
  end
end
