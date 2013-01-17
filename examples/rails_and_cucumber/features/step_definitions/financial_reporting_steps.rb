Given /^the following transactions:$/ do |table|
  Transaction.truncate
  table.hashes.each do |hash|
    Transaction.create(hash.symbolize_keys)
  end
end

Then /^I should only see the following transactions:$/ do |table|
  verify_transactions(table.hashes)
end

Then /^I should not see any transactions$/ do
  verify_no_transactions
end
