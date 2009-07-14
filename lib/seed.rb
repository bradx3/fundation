User.new(:login => "brad", :password => "password", :password_confirmation => "password", :email => "brad@test.com").save!

expenses = Fund.new(:name => "Expenses", :default_synchronize_fund => true)
expenses.save!
home_loan = Fund.new(:name => "Home Loan", :dollars => 50000)
home_loan.save!
tax = Fund.new(:name => "Tax", :dollars => 8000)
tax.save!

dt = DepositTemplate.new(:name => "Tax to pay")
dt.save!
dt.deposit_template_fund_percentages.new(:fund => tax, :percentage => 35).save!
dt.deposit_template_fund_percentages.new(:fund => home_loan, :percentage => 30).save!
dt.deposit_template_fund_percentages.new(:fund => expenses, :percentage => 35).save!

puts "Seed data loaded"
