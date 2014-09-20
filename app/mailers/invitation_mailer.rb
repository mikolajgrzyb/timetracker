class InvitationMailer < ActionMailer::Base
  default from: "info@timetracking.com"

  def invite(email, token)
    @link = new_user_registration_url(token: token)
    mail to: email, subject: 'I Invite you to my account!'
  end
end
