# frozen_string_literal: true

class TopicsController < ApplicationController
  include Pagy::Backend

  before_action :set_topic, only: %i[show edit update destroy downvote]
  before_action :authenticate_user!, only: %i[new downvote]

  def index
    @pagy, @topics = pagy(Topic.includes(:user).where(id: topic_ids).order(created_at: :desc))
  end

  def show; end

  def new
    @topic = Topic.new
    @autofocus = true
  end

  def edit
    @autofocus = false
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      clear_cache
      redirect_to @topic, notice: t('topics.saved')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_url(@topic), notice: t('topics.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy!
    redirect_to topics_url, notice: t('topics.deleted')
  end

  def downvote
    @topic.downvote!(current_user)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "topic_#{@topic.id}_downvote_counter",
            partial: 'topics/downvote_counter',
            locals: { counter: @topic.downvotes, topic: @topic }
          )
        ]
      end
    end
  end

  private

  def set_topic
    @topic = Topic.includes(:user).friendly.find(params[:id])
    return unless params[:id] != @topic.slug

    redirect_to @topic, status: :moved_permanently
  end

  def topic_params
    params.require(:topic).permit(:title, :x_link, :hashtag, :user_id)
  end

  def topic_ids
    Rails.cache.fetch('topic_ids') do
      Topic.pluck(:id)
    end
  end

  def clear_cache
    Rails.cache.delete('topic_ids')
  end
end
