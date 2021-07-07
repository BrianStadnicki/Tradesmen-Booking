class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      can :read, Business
      can :manage, Job, tradesmen_profile: user.tradesmen_profile_belongs
      can :read, TradesmenProfile
      can :manage, TradesmenProfile, owner: user
      # TODO: allow viewing all users associated to tradesmen profile
      case user.tradesmen_profile_user.role.name
      when 'Owner'
        can :manage, User, user.tradesmen_profile.users do
          true
        end
      when 'Admin'
        can :update, TradesmenProfile, id: user.tradesmen_profile_belongs.id
        can :manage, User, user.tradesmen_profile_belongs.employees do
          true
        end
      end
    elsif user.booker?
      can :read, Business
      can :manage, Business, owner: user
      can :manage, Job, business: user.business_belongs
      can :read, TradesmenProfile
      case user.business_user.role.name
      when 'Owner'
        can :manage, User, user.business.users do
          true
        end
      when 'Admin'
        can :update, Business, id: user.business_belongs.id
        can :manage, User, user.business_belongs.employees do
          true
        end
      end
    end
  end
end
