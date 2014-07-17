require 'rails_helper'

feature "Signups", :type => :feature do
  subject { page }
  describe "signup page" do
    let(:valid_user) { FactoryGirl.build(:user) }
    before { visit new_user_registration_path }

    describe "with valid information" do
      before do
        fill_in "Name", with: valid_user.name
        fill_in "Password", with: valid_user.password
        fill_in "Confirmation", with: valid_user.password
      end

      it "should create user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end
    end
  end
  describe "new user signup" do
    pending "TODO"
  end
end
