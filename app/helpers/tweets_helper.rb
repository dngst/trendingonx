# frozen_string_literal: true

module TweetsHelper
  def embed_tweet(tweet_url)
    oembed_url = "https://publish.twitter.com/oembed?url=#{CGI.escape(tweet_url)}"

    begin
      Rails.cache.fetch("tweet_#{tweet_url}", expires_in: 12.hours) do
        oembed_response = HTTParty.get(oembed_url)

        if oembed_response.success?
          oembed_response['html'].html_safe
        else
          'Tweet not found'
        end
      end
    rescue StandardError
      'Error embedding tweet'
    end
  end
end
