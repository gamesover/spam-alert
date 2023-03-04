class SpamsController < ApplicationController
  def check
    result = SpamChecker.new(message: params[:message]).check_and_send_notification

    json: { spam: result }
  end
end
