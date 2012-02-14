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
        when :celerity
          Celerity::Browser.new
        else
          Watir::Browser.new(@driver)
      end
    end
  end
end