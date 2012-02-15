Given /^I (?:open|visit|go to) the (.+\s?page)(.*)$/ do |page_name, args|
  self.page = PageModels.create(page_name, args)
  self.page_model = self.page
  self.page.open!
  self.page.verify!
end

Given /^I (?:try to|attempt to|fail to) (?:open|visit|go to) the (.+\s?page)(.*)$/ do |page_name, args|
  self.page = PageModels.create(page_name, args)
  self.page_model = self.page
  self.page.open!
end

Then /^I should (?:see|be on) the (.+\s?page)(.*)$/ do |page_name, args|
  self.page = PageModels.create(page_name, args)
  self.page_model = self.page
  self.page.verify!
end

at_exit do
  driver = PageModels::Configuration.instance.driver
  driver.close if driver.class.to_s == "Watir::Browser"
end

module PageModels
  module CucumberIntegration
    attr_accessor :page, :page_model
  end
end
World(PageModels::CucumberIntegration)
