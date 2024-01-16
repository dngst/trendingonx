# frozen_string_literal: true

module AuthorizationHelper
  def user_topics(topic)
    topic.user == current_user
  end
end
