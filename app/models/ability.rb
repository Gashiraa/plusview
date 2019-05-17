class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.isAdmin
      can :manage, :all
    else
      can :index, :all
      can :manage, Customer
      can :manage, Payment
      can :manage, Ware

    end
  end
end