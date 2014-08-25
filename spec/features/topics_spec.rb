require 'rails_helper'

# RSpec is
#   let
#   it
#   expect
# Capybara is anything web-specific
feature 'Topics' do
  # before :all do
  #   # This would be available in _all_ specs below
  #   # Runs once before any of the specs
  #   @special_user = create :user
  # end
  # before :each runs separately before each

  let(:user) { create :user }

  # v- This is a helper I defined
  it 'lets an existing user post a new topic' do
    login user # <- user function is defined above
    visit topics_path # Capy goes to this page and grabs HTML
    click_on "New Topic" # Capybara finds button by button content

    attrs = attributes_for :topic
    #attrs = { title: "Topic 1", description: "Desc 1" }

    # Filling out the form creates a new topic
    expect do
      within '#new_topic' do
        fill_in 'Title', with: attrs[:title]
        fill_in 'Description', with: attrs[:description]
        click_on 'Propose Topic'
      end
    end.to change(Topic, :count).by(1)

    # `page` shows the content of page
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

  it 'lets users edit their topics' do
    # Look at a topic you created
    # - create a topic
    user = User.create! email: "test@example.com", password: "asdfasdf", name: "First last"
    login user
    topic = user.topics.create! title: "Original title", description: "Topic description"
    # - look at it
    visit topic_path(topic) # the show page for that topic

    # Click edit
    click_on "Edit Topic"

    # Fill out form incorrectly
    fill_in "Title", with: ""
    click_on "Edit Topic"

    # Verify validation re-display
    # - say there was an error with title
    expect( page ).to have_content "Title can't be blank"
    # - still see a form
    expect( page ).to have_selector "form"
    # - still on the same page?
    expect( page.current_url ).to eq topic_path(topic)

    # Fill out form & submit
    fill_in "Title", with: "New Title"
    fill_in "Description", with: "asdfasdfasdf"
    click_on "Edit Topic"

    # Verify changes did save
    # - flash "updated topic"
    # - see new title on page
    expect( page ).to have_content "Updated topic"
    expect( page ).to have_content "New Title"
  end

  it 'does not let users edit other topics'

  it 'can index topics without being logged in'
  it 'prompts users to log in when trying to vote'
end
