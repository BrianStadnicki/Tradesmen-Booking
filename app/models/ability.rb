class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      can :read, Business
      can :manage, Job, tradesmen_profile: user.tradesmen_profile_user.tradesmen_profile
      can :read, TradesmenProfile
      can :manage, TradesmenProfile, owner: user
      if user.tradesmen_profile_user.role.name == 'Admin'
        can :manage, TradesmenProfile, id: user.tradesmen_profile_user.tradesmen_profile.id
      end
    elsif user.booker?
      can :read, Business
    end
  end
end
