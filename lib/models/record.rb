class Record
  attr_reader :phones, :emails

  def initialize(row)
    @raw_csv_row = row
    load_data
  end

  private

  def load_data
    @phones =
      @raw_csv_row
      .headers
      .select { |header| header.to_s.downcase.start_with?('phone') }
      .compact
      .uniq

    @phones =
      @raw_csv_row
      .headers
      .select { |header| header.to_s.downcase.start_with?('email') }
      .compact
      .uniq
  end
end
