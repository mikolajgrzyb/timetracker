class Member < ActiveRecord::Base

  enum role: [ :regular, :admin, :owner ]


  belongs_to :user
  belongs_to :account

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def can_change_state(current_user)
    !((user == current_user) && (owner? || admin?)) || regular?
  end


  def current_and_regular?(current_user)
    current_user == user && regular?
  end

  def admin_with_active_param?(member_params)
    admin? && member_params.has_key?(:active)
  end
end
