require 'capybara/rails'

RSpec.configure do |c|
  helpers = Module.new do
    def login user
      visit new_user_session_path
      within '#new_user' do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
    end
  end

  c.include Devise::TestHelpers, :type => :controller
  c.include helpers
end
