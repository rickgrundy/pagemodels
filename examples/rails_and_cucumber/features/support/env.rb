require 'cucumber/rails'
Capybara.default_selector = :css
ActionController::Base.allow_rescue = false

require 'pagemodels'
Dir.glob(File.join(File.dirname(__FILE__), "pagemodels", "..", "**", "*.rb")).each { |f| require f }

PageModels.configure do |config|
  config.driver = :capybara
  config.integrate :rails
  config.integrate :cucumber
  config.integrate :rspec
end