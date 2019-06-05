# frozen_string_literal: true

class DealsController < ApplicationController
  def index
    deals = api_deals(Rails.application.credentials.pipeline_deals_api_key)
    render json: CalculateDealsTotalByStageService.new.call(deals), status: 200
  rescue PipelineDealsAPI::V3::Errors::PipelineDealsAPIError => e
    render json: { error: "PipelineDeals API problem: #{e.message}" }, status: :unprocessable_entity
  end

  private

  def pipeline_deals_api(api_key)
    PipelineDealsAPI::V3::Client.new(api_key: api_key)
  end

  def api_deals(api_key)
    pipeline_deals_api(api_key).deals['entries']
  end
end
