class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      if user.tradesmen_profile_belongs.present?
        tradesmen_profile = user.tradesmen_profile || user.tradesmen_profile_belongs
        can :read, Business
        can :manage, Job, tradesmen_profile: tradesmen_profile
        cannot :create, Job
        can :read, User, tradesmen_profile_user: { tradesmen_profile: tradesmen_profile }
        can :read, BusinessesTradesmenProfile, tradesmen_profile: tradesmen_profile
        can :read, TradesmenProfile
        can :manage, TradesmenProfile, owner: user
        cannot :create, TradesmenProfile if user.tradesmen_profile_belongs.present?
        case user.tradesmen_profile_user.role.name
        when 'Owner'
          can :manage, User, tradesmen_profile_user: { tradesmen_profile: tradesmen_profile }
          can :create, :destroy, BusinessesTradesmenProfile, tradesmen_profile: tradesmen_profile
        when 'Admin'
          can :update, TradesmenProfile, id: tradesmen_profile.id
          can :manage, User,
              tradesmen_profile_user: { tradesmen_profile: tradesmen_profile, role: { name: 'Employee' } }
          can :create, :destroy, BusinessesTradesmenProfile, tradesmen_profile: tradesmen_profile
        end
        cannot :create, User
      else
        can :create, TradesmenProfile
      end
    elsif user.booker?
      if user.business_belongs.present?
        business = user.business || user.business_belongs
        can :read, Business
        can :manage, Business, owner: user
        cannot :create, Business if user.business_belongs.present?
        can :manage, Job, business: business
        can :read, User, business_user: { business: business }
        can :read, BusinessesTradesmenProfile, business: business
        can :read, TradesmenProfile
        can :trusted, TradesmenProfile
        case user.business_user.role.name
        when 'Owner'
          can :manage, User, business_user: { business: business }
          can :create, :destroy, BusinessesTradesmenProfile, business: business
        when 'Admin'
          can :update, Business, id: business.id
          can :manage, User, business_user: { business: business, role: { name: 'Employee' } }
          can :create, :destroy, BusinessesTradesmenProfile, business: business
        end
        cannot :create, User
      else
        can :create, Business
      end
    end
  end
end
