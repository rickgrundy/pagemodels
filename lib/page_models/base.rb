module PageModels  
  class Base    
    def open!
      visit(url)
      verify!
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
  end
end