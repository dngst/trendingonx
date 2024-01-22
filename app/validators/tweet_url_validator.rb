# frozen_string_literal: true

class TweetUrlValidator < ActiveModel::Validator
  def validate(record)
    return if valid_tweet_url?(record.x_link)

    record.errors.add(:x_link, I18n.t('topics.validations.x_link'))
  end

  private

  def valid_tweet_url?(url)
    prefix = %w[https://twitter.com https://x.com]
    url.present? && prefix.any? { |p| url.start_with?(p) } && url.match?(%r{/status/\d{19}$})
  end
end
