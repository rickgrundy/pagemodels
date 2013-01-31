require File.expand_path(File.dirname(__FILE__) + "../../spec_helper")

describe PageModels::Base do
  class UnimplementedPageModel < PageModels::Base
  end
  
  class TestPageModel < PageModels::Base
    def initialize(url="http://test-page")
      @url = url
    end
    
    def url
      @url
    end
    
    def verify!
      true
    end
  end
  
  before(:each) do
    PageModels::Configuration.instance.stub(:driver).and_return(Watir::Browser.new(:chrome))
    @page_model = TestPageModel.new
  end
  
  describe "template methods which must be implemented by your page models" do
    it "should raise an error if page models do not implement #url" do
      lambda { UnimplementedPageModel.new.url }.should raise_error(PageModels::ImplementationError)
    end
    
    it "should raise an error if page models do not implement #verify!" do
      lambda { UnimplementedPageModel.new.verify! }.should raise_error(PageModels::ImplementationError)
    end
  end
  
  describe "delegating methods to the driver for less verbose page models" do
    it "should delegate a missing method to the driver" do
      PageModels::Configuration.instance.driver.should_receive(:do_something_cool).with(:please)
      @page_model.do_something_cool(:please)
    end
    
    it "should should not hide method missing errors if the method does not exist on the driver" do
      lambda { @page_model.do_something_else }.should raise_error(NoMethodError, "undefined method `do_something_else' for #{@page_model.inspect}")
    end
  end
  
  describe "constructing page URLs" do
    before(:each) do
      PageModels::Configuration.instance.stub(:driver).and_return(Capybara::Session.new)
      PageModels::Configuration.instance.base_url = "https://1.2.3.4:4321"
    end
    
    it "uses the base URL from config" do
      pm = TestPageModel.new("/foo")
      pm.should_receive(:visit).with("https://1.2.3.4:4321/foo")
      pm.open!
    end
    
    it "ignores base URL if http:// is specified" do
      pm = TestPageModel.new("http://foo")
      pm.should_receive(:visit).with("http://foo")
      pm.open!
    end
    
    it "ignores base URL if https:// is specified" do
      pm = TestPageModel.new("https://foo")
      pm.should_receive(:visit).with("https://foo")
      pm.open!
    end    
  end
  
  describe "opening a page with driver" do    
    describe "for capybara" do
      it "should visit the page" do
        PageModels::Configuration.instance.stub(:driver).and_return(Capybara::Session.new)
        @page_model.should_receive(:visit).with("http://test-page")
        @page_model.open!
      end
    end
    
    describe "for celerity" do
      it "should goto the page" do
        PageModels::Configuration.instance.stub(:driver).and_return(Celerity::Browser.new)
        @page_model.should_receive(:goto).with("http://test-page")
        @page_model.open!
      end
    end   
    
    describe "for watir-webdriver" do
      it "should goto the page" do
        PageModels::Configuration.instance.stub(:driver).and_return(Watir::Browser.new(:chrome))
        @page_model.should_receive(:goto).with("http://test-page")
        @page_model.open!
      end
    end 
  end
  
  describe "lifecycle hooks" do
    it "calls hooks before and after _verify" do
      TestPageModel.after_verify :do_something
      TestPageModel.after_verify :do_something_else
      @page_model.should_receive :do_something
      @page_model.should_receive :do_something_else
      
      @page_model._verify!
      
      TestPageModel.before_verify :do_something
      TestPageModel.before_verify :do_something_else
      @page_model.should_receive(:do_something).twice
      @page_model.should_receive(:do_something_else).twice
      
      @page_model._verify!
    end
  end
end