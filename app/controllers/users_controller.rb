class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @topics = Topic.where(user_id: @user.id).order(created_at: :desc)
  end
end
