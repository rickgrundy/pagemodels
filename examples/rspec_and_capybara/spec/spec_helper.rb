require 'capybara/rspec'
require 'page-models'

Dir.glob(File.join(File.dirname(__FILE__), "page_models", "**", "*.rb")).each { |f| require f }

Capybara.default_driver = :selenium

PageModels.configure do |config|
  config.driver = :capybara
  config.integrate :rspec
end