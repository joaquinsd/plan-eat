class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :manage, Recipe
      can :manage, Product
      can :manage, Menu
      can :read, :all
    end
  end
end
