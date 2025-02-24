# frozen_string_literal: true

require 'rspec'
require 'csv'
require 'normalizer'
require 'models/record'

RSpec.describe Record do
  let(:csv_headers) { %w[email_1 email_2 phone_1 phone_2] }
  let(:csv_data) { ['foo@gmail.com', 'bar@yahoo.com', '(111)-222-3333', '+1 444-555-6666'] }
  let(:csv_row) { CSV::Row.new(csv_headers, csv_data) }
  let(:index) { 1 }

  subject(:record) { described_class.new(csv_row, index) }

  describe '#emails' do
    it 'loads emails' do
      expect(record.emails).to eq(['foo@gmail.com', 'bar@yahoo.com'])
    end
  end

  describe '#phones' do
    it 'loads phone numbers' do
      expect(record.phones).to eq(['1112223333', '4445556666'])
    end
  end

  describe '#validation_errors' do
    let(:invalid_email) { 'invalid-email' }
    let(:invalid_phone) { '123' }
    let(:csv_data) { [invalid_email, '', invalid_phone, '']}

    it 'captures the error messages for each invalid field' do
      expect(record.instance_variable_get(:@validation_errors)).to include(
        "Row #{index} Invalid email format: #{invalid_email}",
        "Row #{index} Invalid phone number format: #{invalid_phone}"
      )
    end
  end
end
