PageModels::Base.send(:include, RSpec::Matchers)

module PageModels
  module RSpecIntegration
    attr_accessor :page_model

    def open_page(page_model)
      self.page_model = page_model
      page_model.open!
    end
    
    def should_see_page(page_model)
      self.page_model = page_model
      page_model.verify!
    end
  end
end

Object.send(:include, PageModels::RSpecIntegration)
