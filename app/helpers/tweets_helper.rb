# frozen_string_literal: true

module TweetsHelper
  def embed_tweet_html(tweet_url)
    extract_tweet_id_from_url(tweet_url)
    oembed_url = "https://publish.twitter.com/oembed?url=#{CGI.escape(tweet_url)}"

    begin
      oembed_response = HTTParty.get(oembed_url)
      oembed_response['html'].html_safe
    rescue StandardError
      'Error embedding tweet'
    end
  end

  private

  def extract_tweet_id_from_url(tweet_url)
    match_data = tweet_url.match(%r{twitter\.com/\w+/status/(\d+)})
    match_data[1] if match_data
  end
end
