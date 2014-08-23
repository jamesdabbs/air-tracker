require 'rails_helper'

feature "Signups", :type => :feature do
  describe "signup page" do
    let(:valid_user) { FactoryGirl.build(:user) }
    before { visit new_user_registration_path }

    describe "with valid information" do
      before do
        within("//form[@id='new_user']") do
          fill_in "Name", with: valid_user.name
          fill_in "Email", with: valid_user.email
          fill_in "Password", with: valid_user.password
          fill_in "Password confirmation", with: valid_user.password
        end
      end

      it "should create user" do
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
        expect(current_path).to eq(root_path)        
        expect(page).to have_selector('a', text: "Logout")
      end
    end
  end
end
