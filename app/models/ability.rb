class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities


#user ||= User.new

    can :manage, User do |u|
      u.id == user.id
    end
    can :index, Course
    can :show, Course

    user ||= User.new # guest user (not logged in)
    if user.is_site_admin?
      can :manage, :all
    elsif user.is_business_admin?
      # User
      can :index, User
      can :approve, User
      can :show, User
      can :update, User do |u|
        #partially duplicates above for profile edits
        user.id == u.id or (!u.is_site_admin? and !u.is_business_admin?)
      end
      can :destroy, User do |u|
        #partially duplicates above for profile edits
        user.id == u.id or (!u.is_site_admin? and !u.is_business_admin?)
      end
      can :assign_role, User
      cannot :assign_role, User
      cannot :assign_provider, User

      #Provider
      can :index, Provider
      can :create, Provider
      can :update, Provider
      can :show, Provider
      cannot :assign_provider, Provider

      #Course Stuff
      can :index, CourseAlias
      can :create, CourseAlias
      can :index, CourseName
      can :create, CourseName


    elsif user.is_provider_agent?
      cannot :index, User
      can :manage, Provider do |p|
        p.id == user.provider_id
      end
      cannot :index, Provider

      #Purchase stuff
      can :index, Purchase
      can :show, Purchase do |p|
        p.user_id == user.id
      end

      can :create, Course
      can :update, Course do |c|
        c.provider_id == user.provider_id
      end
			can :buy, Course
      #can :destroy, Course do |c|
      #  c.provider.id == user.provider.id
      #end
    elsif user.is_hr_agent?
      cannot :index, User
      cannot :assign_role, User
      cannot :assign_provider, User
      cannot :approve, User
			can :buy, Course

      can :index, Provider
      can :show, Provider
      #
      #Purchase stuff
      can :index, Purchase
      can :show, Purchase do |p|
        p.user_id == user.id
      end

=begin

      #can :manage, Image # I will have to come back to this
      can :read, Post
      can :new, Post
      can :update, Post, :user_id => user.id
      can :destroy, Post, :user_id => user.id
      can :manage, User, :id => user.id


      # collection based permissions
      # http://stackoverflow.com/questions/5904996/using-cancan-to-authorize-a-resource-based-on-a-many-to-many-association/7260446
      can :create, Post, :communities => {:user_id => user.id}
      # this is for collections to but I can't figure it out
      # https://spin.atomicobject.com/2015/04/29/complex-permissions-rails-cancancan/


=end


    else
      cannot :index, User
    end
  end
end
