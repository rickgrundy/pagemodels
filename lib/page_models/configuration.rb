require 'singleton'

module PageModels  
  class Configuration
    include Singleton
    attr_writer :driver
    attr_accessor :base_url
    
    def initialize
      reset!
    end
    
    def reset!
      @driver = :capybara
      @base_url = "http://localhost:3000"
      @frameworks = []
      @driver_instance = nil
    end
        
    def integrate(framework)
      @frameworks << framework
    end
    
    def integrate!      
      @frameworks.each { |framework| require "page_models/integration/#{framework}" }
    end
    
    def driver
      @driver_instance ||= begin
        case @driver
          when :capybara
            Capybara.current_session
          when :celerity
            Celerity::Browser.new(:javascript_exceptions => true, :log_level => :all)
          else
            Watir::Browser.new(@driver)
        end
      end
    end
  end
end