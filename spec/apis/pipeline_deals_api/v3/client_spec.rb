# frozen_string_literal: true

require 'rails_helper'

describe PipelineDealsAPI::V3::Client do
  subject(:client) { described_class.new(api_key: '123') }

  describe 'deals' do
    context 'when API returns 200 response code' do
      let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
      let(:body) { '{"entries":[{"id":12807214,"name":"King-Cremin","summary":null,"user_id":220090,"created_at":"2016/04/11 13:46:00 -0400","updated_at":"2016/04/11 13:46:00 -0400","is_archived":false,"is_example":null,"source_id":null,"primary_contact_id":null,"deal_stage_id":727384,"probability":50,"status":null,"expected_close_date":null,"closed_time":null,"expected_close_date_event_id":null,"company_id":null,"import_id":null,"value":"44049.04","deal_loss_reason_id":null,"deal_loss_reason_notes":null,"is_sample":false,"revenue_type_id":null,"deal_pipeline_id":201025,"person_ids":[],"shared_user_ids":[],"value_in_cents":4404904,"user":{"id":220090,"first_name":"Glengarry","last_name":"Ross"},"deal_stage":{"id":727384,"percent":50,"name":"Presentation"},"people":[],"currency":{"id":1,"name":"American Dollar","code":"USD","symbol":"$"},"deal_loss_reason":null,"primary_contact":null,"company":null,"revenue_type":null,"deal_copy":null,"collaborators":[],"custom_fields":{"custom_label_1279429":null,"custom_label_1279432":"22024.0"}}]}' }

      it 'parses a JSON response' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }
        expect(response).to receive(:body) { body }

        expect(Oj).to receive(:load) { body }
        subject.deals
      end
    end

    context 'when API returns 401 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::UnauthorizedError }
      let(:response) { Net::HTTPSuccess.new(1.0, '401', 'Unauthorized') }

      it 'raises UnauthorizedError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end

    context 'when API returns 403 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::ForbiddenError }
      let(:response) { Net::HTTPSuccess.new(1.0, '403', 'Forbidden') }

      it 'raises ForbiddenError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end

    context 'when API returns 404 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::NotFoundError }
      let(:response) { Net::HTTPSuccess.new(1.0, '404', 'Not Found') }

      it 'raises NotFoundError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end

    context 'when API returns 422 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::UnprocessableEntityError }
      let(:response) { Net::HTTPSuccess.new(1.0, '422', 'Unprocessable Entity') }

      it 'raises UnprocessableEntityError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end

    context 'when API returns 429 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::TooManyRequestsError }
      let(:response) { Net::HTTPSuccess.new(1.0, '429', 'Too Many Requests') }

      it 'raises TooManyRequestsError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end

    context 'when API returns 500 response code' do
      let(:expected_error) { PipelineDealsAPI::V3::Errors::BadRequestError }
      let(:response) { Net::HTTPSuccess.new(1.0, '500', 'Internal Server Error') }

      it 'raises BadRequestError' do
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }

        expect { subject.deals }.to raise_error(expected_error)
      end
    end
  end
end
