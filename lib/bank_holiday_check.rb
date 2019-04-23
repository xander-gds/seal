require 'json'

class BankHolidayCheck
  def initialize()
  end

  def is_bank_holiday?(date)
    get_england_bank_holiday_dates.include? date
  end

  def bank_holiday_message
    "No PRs to review, it's a bank holiday :bunting:"
  end

private

  def get_england_bank_holiday_dates
    get_all_bank_holidays['england-and-wales']['events'].map { |x| x['date'] }
  end

  def get_all_bank_holidays
    JSON.parse(get_remote_source("https://www.gov.uk/bank-holidays.json"))
  end

  def get_remote_source(url)
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
  end
end
