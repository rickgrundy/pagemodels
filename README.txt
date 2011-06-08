Page Models move complex and copy-pasted code out of your acceptance tests and into easily managed Ruby classes with (optional) integration for Rails, Cucumber, and RSpec.


~~~~~~~~
# env.rb
require 'pagemodels'

PageModels.configure do |config|
  config.driver = :capybara
  config.integrate :rspec
  config.integrate :cucumber
  config.integrate :rails
end


~~~~~~~~~~~~~~~~~~~~~~~~~~
# my_cucumber_test.feature
Given I open the GitHub project page for the user "rickgrundy" and the repo "page-models"
When I look at the commit history
Then I should see at least 3 commits


~~~~~~~~~~~~~~~~~~~~~~
# my_cucumber_steps.rb
When /I look at the commit history/ do
  page_model.navigate_to_commits
end

Then /I should see at least (\d+) commits/ do |count|
  page_model.verify_commit_count(count)
end


~~~~~~~~~~~~~~~~~~~~~~
# GitHubProjectPage.rb
class GitHubProjectPage < PageModels::Base
  def initialize(user, repo)
    @user, @repo = user, repo
  end
  
  def url
    "https://www.github.com/#{@user}/#{@repo}/"
  end
  
  def verify!
    should have_content "#{@user} / #{@repo}"
    should have_content "Source"
    should have_content "Commits"
  end
  
  def navigate_to_commits
    click_link "Commits"
  end
  
  def verify_commit_count(count)
    all(".commit").should have_at_least(count).things
  end
end