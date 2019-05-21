# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateDealsTotalByStageService do
  subject(:service) { described_class.new }

  describe '#call' do
    context 'when passed an empty array' do
      it 'returns an empty array' do
        expect(service.call([])).to eq([])
      end
    end

    context 'when passed deals array' do
      let(:deals) do
        [
          {
            'deal_stage' => {
              'id' => 1,
              'percent' => 50,
              'name' => 'Presentation'
            },
            'value' => '1'
          },
          {
            'deal_stage' => {
              'id' => 1,
              'percent' => 50,
              'name' => 'Presentation'
            },
            'value' => '1.50'
          },
          {
            'deal_stage' => {
              'id' => 2,
              'percent' => 75,
              'name' => 'Negotiation'
            },
            'value' => '2'
          },
          {
            'deal_stage' => {
              'id' => 2,
              'percent' => 75,
              'name' => 'Negotiation'
            },
            'value' => '2.50'
          },
          {
            'deal_stage' => {
              'id' => 3,
              'percent' => 25,
              'name' => 'Request for Info'
            },
            'value' => '3'
          },
          {
            'deal_stage' => {
              'id' => 4,
              'percent' => 100,
              'name' => 'Won'
            },
            'value' => '3.50'
          },
          {
            'deal_stage' => {
              'id' => 1,
              'percent' => 50,
              'name' => 'Presentation'
            },
            'value' => '4'
          },
          {
            'deal_stage' => {
              'id' => 3,
              'percent' => 25,
              'name' => 'Request for Info'
            },
            'value' => '5'
          },
          {
            'deal_stage' => {
              'id' => 2,
              'percent' => 75,
              'name' => 'Negotiation'
            },
            'value' => '1'
          },
          {
            'deal_stage' => {
              'id' => 5,
              'percent' => 0,
              'name' => 'Lost'
            },
            'value' => '1.50'
          },
          {
            'deal_stage' => {
              'id' => 6,
              'percent' => 10,
              'name' => 'Qualified'
            },
            'value' => '2'
          },
          {
            'deal_stage' => {
              'id' => 1,
              'percent' => 50,
              'name' => 'Presentation'
            },
            'value' => '2.50'
          },
          {
            'deal_stage' => {
              'id' => 6,
              'percent' => 10,
              'name' => 'Qualified'
            },
            'value' => '3'
          },
          {
            'deal_stage' => {
              'id' => 3,
              'percent' => 25,
              'name' => 'Request for Info'
            },
            'value' => '3.50'
          },
          {
            'deal_stage' => {
              'id' => 5,
              'percent' => 0,
              'name' => 'Lost'
            },
            'value' => '4'
          },
          {
            'deal_stage' => {
              'id' => 4,
              'percent' => 100,
              'name' => 'Won'
            },
            'value' => '5'
          }
        ]
      end

      let(:reduced_presentation) do
        {
          'total' => 9,
          'percent' => 50,
          'name' => 'Presentation'
        }
      end

      let(:reduced_negotiation) do
        {
          'total' => 5.50,
          'percent' => 75,
          'name' => 'Negotiation'
        }
      end

      let(:reduced_request) do
        {
          'total' => 11.50,
          'percent' => 25,
          'name' => 'Request for Info'
        }
      end

      let(:reduced_won) do
        {
          'total' => 8.50,
          'percent' => 100,
          'name' => 'Won'
        }
      end

      let(:reduced_lost) do
        {
          'total' => 5.50,
          'percent' => 0,
          'name' => 'Lost'
        }
      end

      let(:reduced_qualified) do
        {
          'total' => 5,
          'percent' => 10,
          'name' => 'Qualified'
        }
      end

      let(:sorted_expected) do
        [].push(reduced_lost)
          .push(reduced_qualified)
          .push(reduced_request)
          .push(reduced_presentation)
          .push(reduced_negotiation)
          .push(reduced_won)
      end

      it 'calculates deals total by stage' do
        expect(service.call(deals)).to include(reduced_presentation)
        expect(service.call(deals)).to include(reduced_negotiation)
        expect(service.call(deals)).to include(reduced_request)
        expect(service.call(deals)).to include(reduced_won)
        expect(service.call(deals)).to include(reduced_lost)
        expect(service.call(deals)).to include(reduced_qualified)
      end

      it 'returns totals ordered by percent' do
        expect(service.call(deals)).to eq(sorted_expected)
      end
    end
  end
end
