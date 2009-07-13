Factory.define :user do |o|
  o.sequence(:login) { |n| "person#{ n }" }
  o.password "password"
  o.password_confirmation { |a| a.password }
  o.sequence(:email) { |n| "email_#{ n }@test.com" }
end

Factory.define :account do |o|
  o.sequence(:name) { |n| "account #{ n }" }
  o.initial_balance_in_cents { rand(100000) }
end

Factory.define :deposit_type do |o|
  o.sequence(:name) { |n| "deposit_type #{ n }" }
end

Factory.define :account_transaction do |o|
  o.association :account
end

Factory.define :deposit do |d|
  d.dollars 100
  d.account_transactions do |da| 
    [ da.association(:account_transaction, :dollars => 50), 
      da.association(:account_transaction, :dollars => 50) ]
  end
end
