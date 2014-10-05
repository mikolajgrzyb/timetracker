module MembersHelper

  def can_change_state(member)
    !((member.user == current_user) && (member.owner? || member.admin?)) || member.regular?
  end
end
