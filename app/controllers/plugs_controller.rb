# frozen_string_literal: true

class PlugsController < ApplicationController
  def index
    @plugs = User.joins(:topics)
                 .select('users.*, COUNT(topics.id) as topic_count')
                 .group('users.id')
                 .having('COUNT(topics.id) >= ?', 26)
                 .order('topic_count DESC')
                 .limit(10)
  end
end
