# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/topics' do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user_id: user.id) }

  let(:valid_attributes) do
    { title: 'Title',
      x_link: 'https://twitter.com/CatWorkers/status/1747065669487624601',
      hashtag: 'hashtag', user_id: user.id }
  end

  let(:invalid_attributes) do
    { title: '', x_link: '', hashtag: '', user_id: user.id }
  end

  let(:new_attributes) do
    { title: 'Updated title',
      x_link: 'https://twitter.com/CatWorkers/status/1749242377347244062',
      hashtag: 'newhashtag', user_id: user.id }
  end

  before do
    user
    topic
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get topics_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get topic_url(topic)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      sign_in user

      get new_topic_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      sign_in user

      get edit_topic_url(topic)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Topic' do
        sign_in user

        expect do
          post topics_url, params: { topic: valid_attributes }
        end.to change(Topic, :count).by(1)
      end

      it 'redirects to the created topic' do
        sign_in user

        post topics_url, params: { topic: valid_attributes }
        expect(response).to redirect_to(topic_url(Topic.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Topic' do
        sign_in user

        expect do
          post topics_url, params: { topic: invalid_attributes }
        end.not_to change(Topic, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        sign_in user

        post topics_url, params: { topic: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested topic' do
        sign_in user

        patch topic_url(topic), params: { topic: new_attributes }
        topic.reload
        expect(topic.title).to eq('Updated title')
        expect(topic.x_link).to eq('https://twitter.com/CatWorkers/status/1749242377347244062')
      end

      it 'redirects to the topic' do
        sign_in user

        patch topic_url(topic), params: { topic: new_attributes }
        topic.reload
        expect(response).to redirect_to(topic_url(topic))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        sign_in user

        patch topic_url(topic), params: { topic: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested topic' do
      sign_in user

      expect do
        delete topic_url(topic)
      end.to change(Topic, :count).by(-1)
    end

    it 'redirects to the topics list' do
      sign_in user

      delete topic_url(topic)
      expect(response).to redirect_to(topics_url)
    end
  end
end
