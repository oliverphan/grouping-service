# frozen_string_literal: true

require 'strategies/email_strategy'
require 'models/record'
require 'csv'

RSpec.describe EmailStrategy do
  let(:csv_headers) { %w[email_1 email_2] }
  let(:csv_data) do
    [
      CSV::Row.new(csv_headers, ['foo@gmail.com', 'bar@yahoo.com']),
      CSV::Row.new(csv_headers, ['foo@gmail.com', '']),
      CSV::Row.new(csv_headers, ['random@hotmail.com', 'crazy_email@gmail.com'])
    ]
  end

  let(:record1) { Record.new(csv_data[0]) }
  let(:record2) { Record.new(csv_data[1]) }
  let(:record3) { Record.new(csv_data[2]) }
  let(:records) { [record1, record2, record3] }

  subject(:email_strategy) { described_class.new }

  describe '#find_matches' do
    it 'groups records by shared email addresses' do
      expect(email_strategy.find_matches(records)).to eq([[record1, record2]])
    end
  end
end
