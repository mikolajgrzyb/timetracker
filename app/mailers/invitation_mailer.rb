class InvitationMailer < ActionMailer::Base
  default from: "info@timetracking.com"

  def send_invitation(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail to: @invitation.email, subject: 'I Invite you to my account!'
  end
end
