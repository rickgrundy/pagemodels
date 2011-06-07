module PageModels
  class ConfigurationError < StandardError
  end
    
  class ImplementationError < StandardError
    def initialize(page_model, method)
      super("#{page_model.class} must implement ##{method}.")
    end
  end
end