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
