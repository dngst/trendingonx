# frozen_string_literal: true

class PlugsController < ApplicationController
  def index
    @plugs = User.top_users(10, 26)
  end
end
