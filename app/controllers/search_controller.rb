# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @topics = Topic.search_by_title_x_link_and_hashtag(params[:query])
    @users = User.search_by_name_and_slug(params[:query])
  end
end
