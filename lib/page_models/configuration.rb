require 'singleton'

module PageModels  
  class Configuration
    include Singleton
    attr_writer :driver
    
    def initialize
      @driver = :capybara
      @frameworks = []
    end
        
    def integrate(framework)
      @frameworks << framework
    end
    
    def integrate!      
      @frameworks.each { |framework| require "page_models/integration/#{framework}" }
    end
    
    def driver
      case @driver
        when :capybara
          Capybara.current_session
        else
          raise ConfigurationError.new("No driver configured.")
      end
    end
  end
end