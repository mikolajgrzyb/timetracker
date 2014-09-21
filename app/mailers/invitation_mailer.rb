class InvitationMailer < ActionMailer::Base
  default from: "info@timetracking.com"

  def invite(current_user, email)
    @user = current_user
    @link = new_user_registration_url(token: current_user.first_account.token)
    mail to: email, subject: 'I Invite you to my account!'
  end
end
