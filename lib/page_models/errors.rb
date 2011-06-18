module PageModels
  class ConfigurationError < StandardError
  end
    
  class ImplementationError < StandardError
    def initialize(page_model, method)
      super("#{page_model.class} must implement ##{method}.")
    end
  end
  
  class MissingPageModelError < StandardError
    def initialize(klass)
      super("The page model class for #{klass} has not yet been written. You will need to create 'class #{klass} < PageModels:: Base'")
    end
  end
end