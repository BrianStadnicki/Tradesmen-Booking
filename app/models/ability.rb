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
      # TODO: allow viewing all users associated to tradesmen profile
      case user.tradesmen_profile_user.role.name
      when 'Owner'
        can :manage, User, user.tradesmen_profile_user.tradesmen_profile.users do
          true
        end
      when 'Admin'
        can :manage, TradesmenProfile, id: user.tradesmen_profile_user.tradesmen_profile.id
        cannot :destroy, TradesmenProfile, id: user.tradesmen_profile_user.tradesmen_profile.id
        can :manage, User, user.tradesmen_profile_user.tradesmen_profile.employees do
          true
        end
      end
    elsif user.booker?
      can :read, Business
    end
  end
end
