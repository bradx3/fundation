User.new(:login => "brad", :password => "password", :password_confirmation => "password", :email => "brad@test.com").save!

expenses = Account.new(:name => "Expenses", :default_synchronize_fund => true)
expenses.save!
home_loan = Account.new(:name => "Home Loan", :dollars => 50000)
home_loan.save!
tax = Account.new(:name => "Tax", :dollars => 8000)
tax.save!

dt = DepositType.new(:name => "Tax to pay")
dt.save!
dt.deposit_type_account_percentages.new(:account => tax, :percentage => 35).save!
dt.deposit_type_account_percentages.new(:account => home_loan, :percentage => 30).save!
dt.deposit_type_account_percentages.new(:account => expenses, :percentage => 35).save!

puts "Seed data loaded"
