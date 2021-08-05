class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      if user.tradesmen_profile_belongs.present?
        tradesmen_profile = user.tradesmen_profile || user.tradesmen_profile_belongs
        can :read, Business
        can :read, Job, tradesmen_profile: tradesmen_profile
        can :read, Job,
            business: { tradesmen_businesses_tradesmen_profiles: { tradesmen_profile_id: tradesmen_profile.id } },
            active: true, tradesmen_profile: nil
        can :read, User, tradesmen_profile_user: { tradesmen_profile: tradesmen_profile }
        can :read, BusinessesTradesmenProfile, tradesmen_profile: tradesmen_profile
        can :read, TradesmenProfile
        can :manage, TradesmenProfile, owner: user
        cannot :create, TradesmenProfile if user.tradesmen_profile_belongs.present?
        can :trusted, Business
        # FIXME: only allow creating applications to jobs from businesses trusted to
        can :create, JobTradesmenApplication, tradesmen_profile: tradesmen_profile
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
        can :read, TradesmenProfile, id: nil
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
        can :update, JobTradesmenApplication, job: { business: business }
        case user.business_user.role.name
        when 'Owner'
          can :manage, User, business_user: { business: business }
          can :manage, BusinessesTradesmenProfile, business: business
        when 'Admin'
          can :update, Business, id: business.id
          can :manage, User, business_user: { business: business, role: { name: 'Employee' } }
          can :manage, BusinessesTradesmenProfile, business: business
        end
        cannot :create, User
      else
        can :create, Business
        can :read, Business, id: nil
      end
    end
  end
end
