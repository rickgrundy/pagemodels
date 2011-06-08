class GoogleSearchPage < PageModels::Base
  def url
    "http://www.google.com.au/"
  end
  
  def verify!
    should have_content "About Google"
    should_not have_content "More search tools"
  end
  
  def search_for(query)
    fill_in "q", :with => query
    click_button "Google Search"
  end
end