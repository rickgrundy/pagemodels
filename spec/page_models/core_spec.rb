require File.expand_path(File.dirname(__FILE__) + "../../spec_helper")

class MyTestPage < PageModels::Base
  attr_accessor :args
  def initialize(*args)
    @args = args
  end
end

class My123Page < MyTestPage; end

class MyHTMLPage < MyTestPage; end

describe PageModels do
  describe "creating instances from cucumber (or similar) text" do
    it "should create an instance with no args" do
      page_model = PageModels.create("my test page", "")
      page_model.args.should == []
    end
  
    it "should create an instance with 1..n args" do
      page_model = PageModels.create("my test page", 'with "some" additional "arguments" denoted by "quotes"')
      page_model.args.should == ["some", "arguments", "quotes"]
    end
    
    it "should raise a helpful error when the class does not exist" do
      lambda { page_model = PageModels.create("not real page", "") }.should raise_error(PageModels::MissingPageModelError)
    end
    
    it "should support numbers in page names" do
      page_model = PageModels.create("my 123 page", "")
      page_model.args.should == []
    end
    
    it "should allow uppercase in page names" do
      page_model = PageModels.create("My HTML page", "")
      page_model.args.should == []
    end
  end
end