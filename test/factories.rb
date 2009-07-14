Factory.define :family do |f|
end

Factory.define :user do |o|
  o.sequence(:login) { |n| "person#{ n }" }
  o.password "password"
  o.association :family
  o.password_confirmation { |a| a.password }
  o.sequence(:email) { |n| "email_#{ n }@test.com" }
end

Factory.define :fund do |o|
  o.sequence(:name) { |n| "fund #{ n }" }
  o.initial_balance_in_cents { rand(100000) }
  o.association :user
end

Factory.define :deposit_template do |o|
  o.sequence(:name) { |n| "deposit_template #{ n }" }
end

Factory.define :fund_transaction do |o|
  o.association :fund
end

Factory.define :deposit do |d|
  d.dollars 100
  d.association :user
  d.fund_transactions do |da| 
    [ da.association(:fund_transaction, :dollars => 50), 
      da.association(:fund_transaction, :dollars => 50) ]
  end
end

Factory.define :withdrawal do |w|
  w.dollars 100
  w.association :user
end
