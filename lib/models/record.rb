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
      .map { |header| Normalizer.normalize_emails(@raw_csv_row[header]) }

    @phones =
      @raw_csv_row
      .fields(*@raw_csv_row.headers.grep(/^phone/i))
  end
end
