# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  describe 'GET #index' do
    before do
      expect(controller).to receive(:api_deals)
    end

    context 'when successful response from PipelineDeals API' do
      let(:deals) { [] }

      it 'returns http success' do
        expect(CalculateDealsTotalByStageService).to receive(:new).and_return(
          service = double(:service, call: deals)
        )
        expect(service).to receive(:call)

        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context 'when fail response from PipelineDeals API' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::TooManyRequestsError }

      it 'returns unprocessable entity response' do
        expect(CalculateDealsTotalByStageService).to receive(:new).and_return(
          service = double(:service)
        )
        expect(service).to receive(:call).and_raise(expected_error)

        get :index

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include 'error'
      end
    end
  end
end
