PageModels::Base.send(:include, RSpec::Matchers)

module PageModels
  module RSpecIntegration
    def open_page(page_model)
      page_model = page_model.new if page_model.is_a? Class
      $page_model = page_model
      page_model.open!
    end
    
    def should_see_page(page_model)
      page_model = page_model.new if page_model.is_a? Class      
      $page_model = page_model
      page_model.verify!
    end
    
  end
  
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

Object.send(:include, PageModels::RSpecIntegration)
RSpec.configure { |c| c.include PageModels::PageModelMethodDelegation }