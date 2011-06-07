require File.expand_path(File.dirname(__FILE__) + "../../spec_helper")

module Capybara
  def self.current_session
    @session ||= Object.new
  end
end

describe PageModels::Configuration do
  before(:each) do
    @config = PageModels::Configuration.instance
  end
  
  describe "providing a driver" do
    it "should raise an error if no driver is configured" do
      @config.driver = nil
      lambda { @config.driver }.should raise_error(PageModels::ConfigurationError)
    end
    
    it "should provide a Capybara session" do
      @config.driver = :capybara
      @config.driver.should == Capybara.current_session
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