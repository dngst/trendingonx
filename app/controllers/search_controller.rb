# frozen_string_literal: true

class SearchController < ApplicationController
  include Pagy::Backend

  def index
    @query = Topic.search(params[:query])
    @pagy, @topics = pagy(@query)
  end
end
