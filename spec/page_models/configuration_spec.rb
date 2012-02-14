require File.expand_path(File.dirname(__FILE__) + "../../spec_helper")

module Capybara
  def self.current_session
    @session ||= Object.new
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

describe PageModels::Configuration do
  before(:each) do
    @config = PageModels::Configuration.instance
  end
  
  describe "providing a driver" do    
    it "should provide a Capybara session" do
      @config.driver = :capybara
      @config.driver.should == Capybara.current_session
    end
    
    it "should provide a Celerity browser" do
      @config.driver = :celerity
      @config.driver.should be_a Celerity::Browser
    end
    
    describe "for watir-webdriver" do    
      it "should support Chrome" do
        @config.driver = :chrome
        @config.driver.should be_a Watir::Browser
        @config.driver.browser.should == :chrome
      end
      
      it "should support Chrome" do
        @config.driver = :firefox
        @config.driver.should be_a Watir::Browser
        @config.driver.browser.should == :firefox
      end
      
      it "should support IE" do
        @config.driver = :ie
        @config.driver.should be_a Watir::Browser
        @config.driver.browser.should == :ie
      end
    end
  end
  
  describe "integrating with frameworks" do
    it "should require the appropriate integration files" do
      @config.integrate :foo
      @config.integrate :bar
      
      @config.should_receive(:require).with("page_models/integration/foo")
      @config.should_receive(:require).with("page_models/integration/bar")
      
      @config.integrate!
    end
  end
end