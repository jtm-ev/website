class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    else
      # can :read, :all
      
      can :read, Page, public: true
      can :read, Location
      can :read, Project
      can :read, Member
      
      
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
      
      if user.is_member_manager?
        can :manage, Member
        can :manage, Group
      end
      
      can :manage, Page if user.is_site_manager?
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
