Factory.define :user do |o|
  o.sequence(:login) { |n| "person#{ n }" }
  o.password "password"
  o.password_confirmation { |a| a.password }
  o.email "email@test.com"
end

Factory.define :account do |o|
  o.sequence(:name) { |n| "account #{ n }" }
  o.balance_in_cents { rand(100000) }
end

Factory.define :deposit_type do |o|
  o.sequence(:name) { |n| "deposit_type #{ n }" }
end

Factory.define :deposit_account do |o|
  o.association :account
end

Factory.define :deposit do |d|
  d.dollars 100
  d.deposit_accounts do |da| 
    [ da.association(:deposit_account, :dollars => 50), 
      da.association(:deposit_account, :dollars => 50) ]
  end
end
