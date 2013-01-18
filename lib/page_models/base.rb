module PageModels  
  class Base
    @@callbacks = {:before_verify => [], :after_verify => []}

    def self.before_verify(method_name)
      @@callbacks[:before_verify] << method_name
    end
        
    def self.after_verify(method_name)
      @@callbacks[:after_verify] << method_name
    end
    
    def open!
      if config.driver.class.to_s == "Capybara::Session"
        visit(full_url)
      else
        goto(full_url)
      end
      verify!
    end
    
    def _verify!
      @@callbacks[:before_verify].each { |callback| send(callback) if respond_to?(callback) }      
      verify!
      @@callbacks[:after_verify].each { |callback| send(callback) if respond_to?(callback) }
    end
    
    def method_missing(name, *args, &block)
      config.driver.send(name, *args, &block)
    rescue NoMethodError
      super(name, *args, &block)
    end
    
    def url
       raise ImplementationError.new(self, __method__)
    end

    def verify!
       raise ImplementationError.new(self, __method__)
    end
    
    private
    
    def config
      PageModels::Configuration.instance
    end
    
    def full_url
      url =~ /^https?:\/\// ? url : config.base_url + url
    end
  end
end