class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      can :read, Business
      can :manage, Job, tradesmen_profile: user.tradesmen_profile_belongs
      can :read, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs }
      can :read, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
      can :read, TradesmenProfile
      can :manage, TradesmenProfile, owner: user
      case user.tradesmen_profile_user.role.name
      when 'Owner'
        can :manage, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile }
        can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile
      when 'Admin'
        can :update, TradesmenProfile, id: user.tradesmen_profile_belongs.id
        can :manage, User,
            tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs, role: { name: 'Employee' } }
        can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
      end
    elsif user.booker?
      can :read, Business
      can :manage, Business, owner: user
      can :manage, Job, business: user.business_belongs
      can :read, User, business_user: { business: user.business_belongs }
      can :read, BusinessesTradesmenProfile, business: user.business_belongs
      can :read, TradesmenProfile
      case user.business_user.role.name
      when 'Owner'
        can :manage, User, business_user: { business: user.business }
        can :destroy, BusinessesTradesmenProfile, business: user.business_belongs
      when 'Admin'
        can :update, Business, id: user.business_belongs.id
        can :manage, User, business_user: { business: user.business, role: { name: 'Employee' } }
        can :destroy, BusinessesTradesmenProfile, business: user.business_belongs
      end
    end
  end
end
