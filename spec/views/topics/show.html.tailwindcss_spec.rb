# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'topics/show' do
  before do
    assign(:topic, Topic.create!(
                     title: 'Title',
                     x_link: 'X Link',
                     hashtag: 'Hashtag',
                     user: nil
                   ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/X Link/)
    expect(rendered).to match(/Hashtag/)
    expect(rendered).to match(//)
  end
end
