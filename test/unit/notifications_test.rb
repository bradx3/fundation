require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  setup do
    ActionMailer::Base.default_url_options[:host] = "test_host"
  end

  should "create user_created email" do
    creator = Factory.create(:user)
    user = Factory.create(:user, :family => creator.family)

    @expected.subject = "You have been signed up for #{ $SITE_NAME }"
    @expected.from = creator.email
    @expected.to = user.email

    created = Notifications.user_created(user, creator)
    assert_equal @expected.subject, created.subject
    assert_equal @expected.from, created.from
    assert_equal @expected.to, created.to

    assert created.body.include?("token=#{ user.perishable_token }")
  end  

end
