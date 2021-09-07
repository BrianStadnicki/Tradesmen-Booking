class Ability
  include CanCan::Ability

  def initialize(user)
    can :service_worker, ServiceWorker
    can :manifest, ServiceWorker
    if user
      can :read, User, id: user.id
      can :update, User, id: user.id
      can :current_id, User
      can :index, Notification
      can :read, Notification
      can :update, Notification, :read
      if user.admin?
        can :manage, :all
      elsif user.tradesmen?
        if user.tradesmen_profile_belongs.present?
          can :read, Business
          can :read, Job, tradesmen_profile: user.tradesmen_profile_belongs
          can :read, Job,
              business: { tradesmen_businesses_tradesmen_profiles: { tradesmen_profile_id: user.tradesmen_profile_belongs.id } },
              active: true, tradesmen_profile: nil
          can :update, Job, :status, tradesmen_profile: user.tradesmen_profile_belongs
          can :update, Job, :status_been_started, tradesmen_profile: user.tradesmen_profile_belongs
          can :update, Job, :status_been_completed, tradesmen_profile: user.tradesmen_profile_belongs
          can :update, Job, :active, tradesmen_profile: user.tradesmen_profile_belongs
          can :read, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs }
          can :read, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
          can :read, TradesmenProfile, id: user.tradesmen_profile_belongs.id
          can :manage, TradesmenProfile, owner: user
          cannot :create, TradesmenProfile if user.tradesmen_profile_belongs.present?
          can :trusted, Business
          can :mine, Job, tradesmen_profile: user.tradesmen_profile_belongs
          can :mine_active, Job, tradesmen_profile: user.tradesmen_profile_belongs, active: true
          can :applicable, Job, business: { tradesmen_businesses_tradesmen_profiles: { tradesmen_profile_id: user.tradesmen_profile_belongs.id } },
              active: true, tradesmen_profile: nil
          # FIXME: only allow creating applications to jobs from businesses trusted to
          can :create, JobTradesmenApplication, tradesmen_profile: user.tradesmen_profile_belongs
          can :update, JobTradesmenApplication, tradesmen_profile: user.tradesmen_profile_belongs
          case user.tradesmen_profile_user.role.name
          when 'Owner'
            can :manage, User, tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs }
            can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
          when 'Admin'
            can :update, TradesmenProfile, id: user.tradesmen_profile_belongs.id
            can :manage, User,
                tradesmen_profile_user: { tradesmen_profile: user.tradesmen_profile_belongs, role: { name: 'Employee' } }
            can :destroy, BusinessesTradesmenProfile, tradesmen_profile: user.tradesmen_profile_belongs
          end
          cannot :create, User
        else
          can :create, TradesmenProfile
          can :read, TradesmenProfile, id: nil
        end
      elsif user.booker?
        if user.business_belongs.present?
          can :read, Business, id: user.business_belongs.id
          can :manage, Business, owner: user
          cannot :create, Business if user.business_belongs.present?
          can :create, Job, business: user.business_belongs
          can :read, Job, business: user.business_belongs
          can :update, Job, business: user.business_belongs
          can :mine, Job, business: user.business_belongs
          can :mine_active, Job, business: user.business_belongs, active: true
          can :read, User, business_user: { business: user.business_belongs }
          can :read, BusinessesTradesmenProfile, business: user.business_belongs
          can :read, TradesmenProfile
          can :trusted, TradesmenProfile
          can :update, JobTradesmenApplication, job: { business: user.business_belongs }
          case user.business_user.role.name
          when 'Owner'
            can :manage, User, business_user: { business: user.business_belongs }
            can :manage, BusinessesTradesmenProfile, business: user.business_belongs
          when 'Admin'
            can :update, Business, id: user.business_belongs.id
            can :manage, User, business_user: { business: user.business_belongs, role: { name: 'Employee' } }
            can :manage, BusinessesTradesmenProfile, business: user.business_belongs
          end
          cannot :create, User
        else
          can :create, Business
          can :read, Business, id: nil
        end
      end
    end
  end
end
