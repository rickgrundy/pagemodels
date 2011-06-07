This example demonstrates how to use page models with RSpec to write acceptance tests for any website (in this case Google.com), using Capybara/Selenium/Firefox as a driver.

~~~~~~~~~~

See features/spec/spec_helper.rb for information about configuring PageModels to integrate with the various frameworks:

PageModels.configure do |config|
  config.driver = :capybara
  config.integrate :rspec
end

spec_helper.rb also loads all everything in the page_models directory. GoogleSearchPage and GoogleResultsPage provide examples of page models which override PageModels::Base.

~~~~~~~~~~

RSpec integration exposes two convenience methods you may use in your specs: 

open_page(page_model) - switches the current page model to the one provided and calls #open!
should_see_page(page_model) - switches the current page model and calls #verify!