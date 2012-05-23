module PageModels  
  class Base    
    def open!
      if config.driver.class.to_s == "Capybara::Session"
        visit(full_url)
      else
        goto(full_url)
      end
    end
    
    def method_missing(name, *args, &block)
      puts name
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