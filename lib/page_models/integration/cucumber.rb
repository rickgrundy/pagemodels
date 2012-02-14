Given /^I open the (.+ page)(.*)$/ do |page, args|
  self.page_model = PageModels.create(page, args)
  page_model.open!
end

Then /^I should see the (.+ page)(.*)$/ do |page, args|
  self.page_model = PageModels.create(page, args)
  page_model.verify!
end

at_exit do
  driver = PageModels::Configuration.instance.driver
  driver.close if driver.class.to_s == "Watir::Browser"
end

module PageModels
  module CucumberIntegration
    attr_accessor :page_model
  end
end
World(PageModels::CucumberIntegration)
