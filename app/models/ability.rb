# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # can :read, :all
    # can :read, Banner
    # can :read, Listing
    can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'

    if user.admin?
      can :manage, :all
    else
      can :read, Category
      can :read, Continent

      can :manage, Subcategory
      can :manage, Country
      can :manage, Region
      can :manage, City
    end
  end
end
