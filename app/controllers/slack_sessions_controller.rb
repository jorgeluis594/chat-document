# frozen_string_literal: true

class SlackSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    # TODO: add session logic
    session_data = request.env["omniauth.auth"]
  end
end
