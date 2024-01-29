# frozen_string_literal: true

class TopicsController < ApplicationController
  include Pagy::Backend

  before_action :set_topic, only: %i[show edit update destroy downvote]
  before_action :authenticate_user!, only: %i[new downvote]

  # GET /topics or /topics.json
  def index
    ids = Rails.cache.fetch('topic_ids') do
      Topic.pluck(:id)
    end
    @pagy, @topics = pagy(Topic.where(id: ids).order(created_at: :desc))
  end

  # GET /topics/1 or /topics/1.json
  def show; end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit; end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        Rails.cache.delete('topic_ids')
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy!

    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:title, :x_link, :hashtag, :user_id)
  end
end
