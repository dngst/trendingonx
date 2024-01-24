# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  def profile
    @user = User.friendly.find(params[:id])
    @query = Topic.where(user_id: @user.id).order(created_at: :desc)
    @pagy, @topics = pagy(@query)
  end
end
