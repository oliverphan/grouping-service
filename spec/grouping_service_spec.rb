# frozen_string_literal: true

require 'grouping_service'

RSpec.describe GroupingService do
  let(:matching_strategy) { 'email' }
  let(:grouping_service) { GroupingService.new(matching_strategy) }

  let(:csv_headers) { %w[email_1 email_2] }
  let(:csv_data) do
    [
      CSV::Row.new(csv_headers, ['foo@gmail.com', 'bar@yahoo.com']),
      CSV::Row.new(csv_headers, ['foo@gmail.com', '']),
      CSV::Row.new(csv_headers, ['random@hotmail.com', 'crazy_email@gmail.com'])
    ]
  end

  let(:record1) { Record.new(csv_data[0], 1) }
  let(:record2) { Record.new(csv_data[1], 2) }
  let(:record3) { Record.new(csv_data[2], 3) }
  let(:records) { [record1, record2, record3] }

  describe '#load_records' do
    it 'loads records into the service' do
      grouping_service.load_records(records)
      expect(grouping_service.instance_variable_get(:@records)).to eq([record1, record2, record3])
    end
  end

  describe '#group_records' do
    it 'groups records and assigns unique IDs' do
      grouping_service.load_records(records)
      groups = grouping_service.group_records
      expect(groups[record1]).to eq(1)
      expect(groups[record2]).to eq(1)
      expect(groups[record3]).to eq(2)
    end
  end
end
