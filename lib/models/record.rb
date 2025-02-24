# frozen_string_literal: true

require_relative '../normalizer'
require_relative '../validators/validation_error'
require_relative '../validators/email_validator'
require_relative '../validators/phone_validator'

# Record representing a row in the csv file
# @attr_reader phones [Array<String>] The normalized phone numbers
# @attr_reader emails [Array<String>] The normalized email addresses
class Record
  attr_reader :phones, :emails

  ##
  # Initializes a new Record object from the given CSV row
  #
  # @param row [CSV::Row]
  # @param index
  def initialize(row, index)
    @raw_csv_row = row
    @index = index
    @validation_errors = []
    load_data
  end

  private

  ##
  # Loads the email and phone data from the CSV row and normalizes
  # Any validation errors encountered are added to @validation_errors
  def load_data
    @emails =
      @raw_csv_row
      .fields(*@raw_csv_row.headers.grep(/^email/i))
      .map do |field|
        begin
          EmailValidator.validate(field)
          Normalizer.normalize_emails(field)
        rescue ValidationError => e
          @validation_errors << "Row #{@index} #{e.message}"
        end
      end

    @phones =
      @raw_csv_row
      .fields(*@raw_csv_row.headers.grep(/^phone/i))
      .map do |field|
        begin
          normalized_phone_number = Normalizer.normalize_phones(field)
          PhoneValidator.validate(normalized_phone_number)
          normalized_phone_number
        rescue ValidationError => e
          @validation_errors << "Row #{@index} #{e.message}"
        end
      end
  end
end
