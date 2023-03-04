# frozen_string_literal: true

class SpamsController < ApplicationController
  def check
    result = SpamChecker.new(message: params[:message]).check_and_send_notification

    render json: { spam: result }
  end
end
