# frozen_string_literal: true

module UsernameHelper
  def format_name(user)
    user.username[0, 4]
  end
end
