if ENV["COVERAGE"]
  require 'simplecov'

  SimpleCov.start 'rails' do
    add_filter ".bundle"
  end
end
