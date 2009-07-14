f = Family.new
f.save!

u = f.users.build(:login => "brad", :password => "password", :password_confirmation => "password", :email => "brad@test.com")
u.save!

expenses = Fund.new(:name => "Expenses", :user => u, :default_synchronize_fund => true)
expenses.save!
home_loan = Fund.new(:name => "Home Loan", :user => u, :dollars => 0)
home_loan.save!
tax = Fund.new(:name => "Tax", :user => u, :dollars => 0)
tax.save!
Fund.new(:name => "Car Fund", :user => u, :dollars => 0).save!
Fund.new(:name => "Holiday Fund", :user => u, :dollars => 0).save!
Fund.new(:name => "Unemployment Insurance", :user => u, :dollars => 0).save!
Fund.new(:name => "Teeth Fund", :user => u, :dollars => 0).save!

dt = DepositTemplate.new(:name => "Tax to pay", :user => u)
dt.save!
dt.deposit_template_fund_percentages.new(:fund => tax, :percentage => 35).save!
dt.deposit_template_fund_percentages.new(:fund => home_loan, :percentage => 30).save!
dt.deposit_template_fund_percentages.new(:fund => expenses, :percentage => 35).save!

puts "Seed data loaded"
