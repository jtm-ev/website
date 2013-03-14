class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:admin)
      can :manage, :all
    else
      # can :read, :all
      
      can :read, Page, public: true
      can :read, Location
      can :read, Project
      can :read, Member
      
      #############################################################
      # What ALL logged in user can do
      #############################################################
      # unless user.new_record?
      #   can :read, Page
      # end
      
      #############################################################
      # Resources a default User can manage by his own
      #############################################################
      can :update, User do |u|
        u === user
      end
      
      can :update, Member do |member|
        user.member === member
      end
      
      can :update, TeamMembership do |tms|
        user.member === tms.member
      end

      #############################################################
      # What Group-Leaders can do
      #############################################################
      can [:update, :read], Page do |page|
        group = page.group
        group ? user.member.has_role?(:group_leader, group) : false
      end
      #############################################################
      
      if user.has_role?(:member_manager)
        can :manage, Member
        can :manage, Group
      end
      
      can :manage, Page if user.has_role?(:site_manager)
    end
    
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
