FactoryGirl.define do
	factory :user do		
		sequence(:email) { |n| "user#{n}@example.com" }
		name "First Last" 
		password "password"
		password_confirmation "password"
	end

	factory :topic do
		sequence(:title) { |n| "Topic Title #{n}" }
		sequence(:description) { |n| "Topic Description #{n}" }
		user
	end
end