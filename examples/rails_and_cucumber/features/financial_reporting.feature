Feature: Viewing financial reports
  As an Acme Financial Reporting accountant
  I want to see reports for specific types of transaction
  So that I know how much commission to pay my suppliers.

Background:
  Given the following transactions:
  | type | amount | year |
  | visa | $100   | 2011 |
  | cash | $50    | 2011 |
  | visa | $30    | 1999 |
  | visa | $80    | 2011 |

Scenario: Viewing visa transactions for 2011
  When I open the financial report page for "visa" in "2011"
  Then I should only see the following transactions:
  | type | amount |
  | visa | $100   |
  | visa | $80    |
  
Scenario: Viewing cash transactions for 2011
  When I open the financial report page for "cash" in "2011"
  Then I should only see the following transactions:
  | type | amount |
  | cash | $50   |  

Scenario: Viewing cash transactions for 1999
  When I open the financial report page for "cash" in "1999"
  Then I should not see any transactions