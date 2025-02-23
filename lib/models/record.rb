# frozen_string_literal: true

require_relative '../normalizer'

class Record
  attr_reader :phones, :emails

  def initialize(row)
    @raw_csv_row = row
    load_data
  end

  private

  def load_data
    @emails =
      @raw_csv_row
      .fields(*@raw_csv_row.headers.grep(/^email/i))
      .map { |field| Normalizer.normalize_emails(field) }

    @phones =
      @raw_csv_row
      .fields(*@raw_csv_row.headers.grep(/^phone/i))
      .map { |field| Normalizer.normalize_phones(field) }
  end
end
