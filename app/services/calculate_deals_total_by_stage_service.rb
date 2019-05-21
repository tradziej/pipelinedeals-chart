# frozen_string_literal: true

class CalculateDealsTotalByStageService
  def call(deals)
    result = combine_total_by_stage(deals)
    sort(result).values
  end

  private

  def combine_total_by_stage(deals)
    data = Hash.new { |h, v| h[v] = Hash.new(0) }
    deals.each do |deal|
      data[deal['deal_stage']['id']]['total'] += BigDecimal(deal['value'])
      data[deal['deal_stage']['id']]['percent'] = deal['deal_stage']['percent']
      data[deal['deal_stage']['id']]['name'] = deal['deal_stage']['name']
    end
    data
  end

  def sort(data)
    data.sort_by { |_, v| v['percent'] }.to_h
  end
end
