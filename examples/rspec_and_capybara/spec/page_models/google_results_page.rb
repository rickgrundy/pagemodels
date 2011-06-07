class GoogleResultsPage < PageModels::Base
  def initialize(query)
    @query = query
  end
  
  def verify!
    should have_content @query
    should have_content "More search tools"
  end
  
  def verify_more_than_one_page_of_results
    all("table#nav a.fl").should have_at_least(2).things
  end
  
  def verify_special_results_option(option)
    within("#leftnav") do
      should have_content option
    end
  end
  
  def verify_top_result(url)
    find("#search cite:first").text.should == url
  end
end