Given /^I open the (.+ page)(.*)$/ do |page, args|
  page_model = PageModels.create(page, args)
  page_model.open!
end

Then /^I should see the (.+ page)(.*)$/ do |page, args|
  page_model = PageModels.create(page, args)
  page_model.verify!
end

module PageModels
  module CucumberIntegration
    attr_accessor :page_model
  end
end
World(PageModels::CucumberIntegration)
