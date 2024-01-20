# frozen_string_literal: true

module TopicDateHelper
  def posted_on(datetime)
    sanitize(datetime.strftime('%b %d, %Y &middot; %I:%M %p'))
  end
end
