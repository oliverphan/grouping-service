# frozen_string_literal: true

require 'strategies/phone_strategy'
require 'models/record'
require 'csv'

RSpec.describe PhoneStrategy do
  let(:csv_headers) { %w[phone1 phone_2] }
  let(:csv_data) do
    [
      CSV::Row.new(csv_headers, ['(111)-222-3333', '+1 444-555-6666']),
      CSV::Row.new(csv_headers, ['111222    3333', '(412)543-6435']),
      CSV::Row.new(csv_headers, ['+1 999 888 7777', '416-123-3456'])
    ]
  end

  let(:record1) { Record.new(csv_data[0], 1) }
  let(:record2) { Record.new(csv_data[1], 2) }
  let(:record3) { Record.new(csv_data[2], 3) }
  let(:records) { [record1, record2, record3] }

  subject(:phone_strategy) { described_class.new }

  describe '#find_matches' do
    it 'groups records by shared phone numbers' do
      expect(phone_strategy.find_matches(records)).to eq([[record1, record2], [record3]])
    end
  end
end
