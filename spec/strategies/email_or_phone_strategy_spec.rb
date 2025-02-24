# frozen_string_literal: true

require 'strategies/email_or_phone_strategy'
require 'models/record'
require 'csv'

RSpec.describe EmailOrPhoneStrategy do
  let(:csv_headers) { %w[email1 email_2 phone1 phone_2] }
  let(:csv_data) do
    [
      CSV::Row.new(csv_headers, ['foo@gmail.com', 'bar@yahoo.com', '(111)-222-3333', '+1 444-555-6666']),
      CSV::Row.new(csv_headers, ['test@gmail.com', '', '111222    3333', '(412)543-6435']),
      CSV::Row.new(csv_headers, ['email@provider.com', 'email2@provider.com', '+1 999 888 7777', '416-123-3456']),
      CSV::Row.new(csv_headers, ['test@gmail.com', 'second@bing.com', '+1 888 888 7777', '912-123-3456']),
      CSV::Row.new(csv_headers, ['', 'email2@provider.com', '+1 111 222 7777', ''])
    ]
  end

  let(:record1) { Record.new(csv_data[0], 1) }
  let(:record2) { Record.new(csv_data[1], 2) }
  let(:record3) { Record.new(csv_data[2], 3) }
  let(:record4) { Record.new(csv_data[3], 4) }
  let(:record5) { Record.new(csv_data[4], 5) }
  let(:records) { [record1, record2, record3, record4, record5] }

  subject(:email_or_phone_strategy) { described_class.new }

  describe '#find_matches' do
    it 'groups records by shared phone numbers' do
      expect(email_or_phone_strategy.find_matches(records)).to eq([[record1, record2, record4], [record3, record5]])
    end
  end
end
