class InvitationMailer < ActionMailer::Base
  default from: "info@timetracking.com"

  def send_invitation(invitation)
    @invitation = invitation
    mail to: @invitation.invitee_email, subject: 'I Invite you to my account!'
  end
end
