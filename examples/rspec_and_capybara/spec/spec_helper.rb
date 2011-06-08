require 'capybara/rspec'
require 'pagemodels'

Dir.glob(File.join(File.dirname(__FILE__), "pagemodels", "**", "*.rb")).each { |f| require f }

Capybara.default_driver = :selenium

PageModels.configure do |config|
  config.driver = :capybara
  config.integrate :rspec
end