# frozen_string_literal: true

class SearchController < ApplicationController
  include Pagy::Backend

  def index
    @query = Topic.search_by_title_x_link_and_hashtag(params[:query])
    @pagy, @topics = pagy(@query)
    @users = User.search_by_name_and_slug(params[:query])
  end
end
