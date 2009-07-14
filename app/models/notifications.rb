class Notifications < ActionMailer::Base

  def user_created(user, creator)
    @user = user
    @creator = creator

    subject    "You have been signed up for #{ $SITE_NAME }"
    recipients user.email
    from       creator.email
  end
end
