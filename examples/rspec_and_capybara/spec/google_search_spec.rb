require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Searching Google" do
  it "should show results for Ruby Page Models" do
    open_page(GoogleSearchPage)
    search_for("Ruby Page Models")

    should_see_page(GoogleResultsPage.new("Ruby Page Models"))
    verify_more_than_one_page_of_results
    verify_special_results_option("Images")
    verify_special_results_option("News")
    
    verify_top_result("http://www.github.com/rickgrundy/pagemodels")
  end
end