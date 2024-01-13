module AuthorizationHelper
  def user_topics(topic)
    topic.user == current_user
  end
end
