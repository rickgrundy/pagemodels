PageModels::Base.send(:include, RSpec::Matchers)

module PageModels
  module RSpecIntegration
    def try_to_open_page(page_model)
      page_model = page_model.new if page_model.is_a? Class
      $page_model = page_model
      $page_model.open!
    end
    
    def open_page(page_model)
      page_model = page_model.new if page_model.is_a? Class
      $page_model = page_model
      $page_model.open!
      $page_model._verify!
    end
    
    def should_see_page(page_model)
      page_model = page_model.new if page_model.is_a? Class      
      $page_model = page_model
      $page_model._verify!
    end
  end
  
  module PageModelMethodDelegation
    def method_missing(name, *args, &block)
      if $page_model && $page_model.respond_to?(name)
        $page_model.send(name, *args, &block) 
      elsif config.driver.respond_to?(name)
        config.driver.send(name, *args, &block)         
      else
        super(name, *args, &block)
      end
    end
    
    private
    
    def config
      PageModels::Configuration.instance
    end
  end
end

Object.send(:include, PageModels::RSpecIntegration)
RSpec.configure { |c| c.include PageModels::PageModelMethodDelegation }