class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.tradesmen?
      can :index, Business
      can :read, Business, :all
      can :read, Job, tradesmen_profile: { id: user.tradesmen_profile.id }
    elsif user.booker?
      can :read, Business
    end
  end
end
