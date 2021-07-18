class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      if user.tradesmen_profile_belongs.present?
        can :read, Business
        can :manage, Job, tradesmen_profile: user.tradesmen_profile_belongs
        cannot :create, Job
        can :read, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs }
        can :read, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
        can :read, TradesmenProfile
        can :manage, TradesmenProfile, owner: user
        cannot :create, TradesmenProfile if user.tradesmen_profile_belongs.present?
        case user.tradesmen_profile_user.role.name
        when 'Owner'
          can :manage, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile }
          can :create, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile
          can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile
        when 'Admin'
          can :update, TradesmenProfile, id: user.tradesmen_profile_belongs.id
          can :manage, User,
              tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs, role: { name: 'Employee' } }
          can :create, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
          can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
        end
        cannot :create, User
      else
        can :create, TradesmenProfile
      end
    elsif user.booker?
      if user.business_belongs.present?
        can :read, Business
        can :manage, Business, owner: user
        cannot :create, Business if user.business_belongs.present?
        can :manage, Job, business: user.business_belongs
        can :read, User, business_user: { business: user.business_belongs }
        can :read, BusinessesTradesmenProfile, business: user.business_belongs
        can :read, TradesmenProfile
        case user.business_user.role.name
        when 'Owner'
          can :manage, User, business_user: { business: user.business }
          can :create, BusinessesTradesmenProfile, business: user.business
          can :destroy, BusinessesTradesmenProfile, business: user.business
        when 'Admin'
          can :update, Business, id: user.business_belongs.id
          can :manage, User, business_user: { business: user.business, role: { name: 'Employee' } }
          can :create, BusinessesTradesmenProfile, business: user.business_belongs
          can :destroy, BusinessesTradesmenProfile, business: user.business_belongs
        end
        cannot :create, User
      else
        can :create, Business
      end
    end
  end
end
