class FinancialReportPage < PageModels::Base
  def initialize(txn_type, year)
    @txn_type = txn_type.parameterize
    @year = year
  end
  
  def url
    financial_report_path(:txn_type => @txn_type, :year => @year)
  end
  
  def verify!
    should have_content "Acme Financial Report for #{@year}"
  end
  
  def verify_transactions(txns)
    rows = all("#report .transaction")
    rows.should have(txns.size).things
    
    txns.each_with_index do |txn, i|
      rows[i].find(".type").should have_content txn["type"]
      rows[i].find(".amount").should have_content txn["amount"]
    end    
  end
  
  def verify_no_transactions
    should have_content "There are no #{@txn_type} transactions for #{@year}"
    all("#report .transaction").should be_empty
  end
end