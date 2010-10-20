class Notifications < ActionMailer::Base
  if Rails.env.development?
    default_url_options[:host] = "fundation.lucky-dip.net"
  else
    default_url_options[:host] = "localhost:3000"
  end

  def user_created(user, creator)
    @user = user
    @creator = creator

    subject    "You have been signed up for #{ $SITE_NAME }"
    recipients user.email
    from       creator.email
  end

  def password_reset_instructions(user)
    subject "Password Reset Instructions"
    from "Fundation <noreply@lucky-dip.net>"
    recipients user.email
    sent_on Time.now
    @edit_password_reset_url = edit_password_resets_url(:id => user.perishable_token)
  end

end
