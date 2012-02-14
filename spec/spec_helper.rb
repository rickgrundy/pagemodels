require File.join(File.dirname(__FILE__), "..", "lib", "pagemodels")

module Capybara
  class Session
  end
  
  def self.current_session
    @session ||= Session.new
  end
end

module Watir
  class Browser
    attr_reader :browser
    def initialize(browser)
      @browser = browser
    end
  end
end

module Celerity
  class Browser
  end
end