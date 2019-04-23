#!/usr/bin/env ruby

require_relative "bank_holiday_check"
require_relative "message_builder"
require_relative "slack_poster"

# Entry point for the Seal!
class Seal
  def initialize(teams)
    @teams = teams
  end

  def bark(mode: nil)
    teams.each do |team|
      bark_at(team, mode: mode)
    end
  end

  private

  attr_reader :teams

  def bark_at(team, mode: nil)
    message = case mode
    when "quotes"
      Message.new(team.quotes.sample)
    else
      if BankHolidayCheck.new.is_bank_holiday?(DateTime.now.strftime("%Y-%m-%d"))
        Message.new(BankHolidayCheck.new.bank_holiday_message, mood: "approval")
      else
        MessageBuilder.new(team).build
      end
    end

    poster = SlackPoster.new(team.channel, message.mood)
    poster.send_request(message.text)
  end
end
