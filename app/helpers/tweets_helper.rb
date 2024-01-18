# frozen_string_literal: true

module TweetsHelper
  def embed_tweet(tweet_url)
    oembed_url = "https://publish.twitter.com/oembed?url=#{CGI.escape(tweet_url)}"

    begin
      oembed_response = HTTParty.get(oembed_url)
      oembed_response['html'].html_safe
    rescue StandardError
      'Error embedding tweet'
    end
  end
end
