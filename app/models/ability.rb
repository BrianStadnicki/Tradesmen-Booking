class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      can :read, Business
      can :read, Job, tradesmen_profile: { id: user.tradesmen_profile.id }
      can :read, TradesmenProfile
      can :manage, TradesmenProfile, owner_id: user.id
      if TradesmenProfileUser.joins(:role).exists? user: user, tradesmen_profile: TradesmenProfile,
                                                   role: { name: 'Admin' }
        can :manage, TradesmenProfile
      end
    elsif user.booker?
      can :read, Business
    end
  end
end
