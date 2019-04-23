require "spec_helper"
require './lib/bank_holiday_check'

RSpec.describe BankHolidayCheck do

  subject(:bank_holiday_check) do
    described_class.new()
  end

  describe 'bank holiday check' do
    it 'determines 2019-12-25 is a bank holiday in England' do
      date = '2019-12-25'
      expect(bank_holiday_check.is_bank_holiday?(date)).to eq(true)
    end
    it 'determines 2019-01-02 is not a bank holiday in England' do
      date = '2019-01-02'
      expect(bank_holiday_check.is_bank_holiday?(date)).to eq(false)
    end
  end

end
