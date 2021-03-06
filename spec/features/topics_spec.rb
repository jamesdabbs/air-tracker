require 'rails_helper'

feature 'Topics' do
  let(:user) { create :user }

  it 'lets an existing user post a new topic' do
    login user
    visit topics_path
    click_on "New Topic"

    attrs = attributes_for :topic
    expect do
      within '#new_topic' do
        fill_in 'Title', with: attrs[:title]
        fill_in 'Description', with: attrs[:description]
        click_on 'Propose Topic'
      end
    end.to change(Topic, :count).by(1)
    expect( page ).to have_content attrs[:description]
  end

  it 'lets users vote on existing topics' do
    topic = create :topic
    login user
    visit topics_path

    expect( first 'tbody > tr' ).to have_content '0'

    first('a.upvote').click
    expect( first 'tbody > tr' ).to have_content '1'
    expect( page ).not_to have_selector 'a.upvote'
  end

  it 'can index topics without being logged in'
  it 'prompts users to log in when trying to vote'
end
