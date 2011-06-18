require File.expand_path(File.dirname(__FILE__) + "../../spec_helper")

describe PageModels::Base do
  class UnimplementedPageModel < PageModels::Base
  end
  
  class TestPageModel < PageModels::Base
    def url
      "/test-page"
    end
    
    def verify!
      true
    end
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
    before(:each) do
      @driver = Object.new
      PageModels::Configuration.instance.stub(:driver).and_return(@driver)
      @page_model = TestPageModel.new
    end
    
    it "should delegate a missing method to the driver" do
      @driver.should_receive(:do_something_cool).with(:please)
      @page_model.do_something_cool(:please)
    end
    
    it "should should not hide method missing errors if the method does not exist on the driver" do
      lambda { @page_model.do_something_else }.should raise_error(NoMethodError, "undefined method `do_something_else' for #{@page_model.inspect}")
    end
  end
  
  describe "opening a page" do
    before(:each) do
      @driver = Object.new
      PageModels::Configuration.instance.stub(:driver).and_return(@driver)
      @page_model = TestPageModel.new
    end
    
    it "should visit the page, then call verify" do
      @page_model.should_receive(:visit).with("/test-page")
      @page_model.should_receive(:verify!)
      @page_model.open!
    end
    
  end
end