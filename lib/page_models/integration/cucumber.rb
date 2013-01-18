Given /^I (?:open|visit|go to) the (.+\s?page)(.*)$/ do |page_name, args|
  $page_model = PageModels.create(page_name, args)
  $page_model.open!
  $page_model._verify!
end

Given /^I (?:try to|attempt to|fail to) (?:open|visit|go to) the (.+\s?page)(.*)$/ do |page_name, args|
  $page_model = PageModels.create(page_name, args)
  $page_model.open!
end

Then /^I should (?:see|be on) the (.+\s?page)(.*)$/ do |page_name, args|
  $page_model = PageModels.create(page_name, args)
  $page_model = self.page  
  $page_model._verify!
end

at_exit do
  driver = PageModels::Configuration.instance.driver
  driver.close if driver.class.to_s == "Watir::Browser"
end

module PageModels
  module PageModelMethodDelegation
    def method_missing(name, *args, &block)
      if $page_model && $page_model.respond_to?(name)
        $page_model.send(name, *args, &block) 
      else
        super(name, *args, &block)
      end
    end
  end
end
World(PageModels::PageModelMethodDelegation)
