class Ability
  include CanCan::Ability

  def initialize(user, cname) # cname из aplication controller для определения Модели
		alias_action :index, :show, :to => :read
		alias_action :new, :to => :create
		alias_action :edit, :to => :update
    # Define abilities for the passed in user here. For example:
      user ||= User.new # guest user (not logged in)
      # puts user.role
      if user.role == "admin"
        can :manage, :all
      end
      if user.role == "manager"
        #can :read, :all
				user.permissions.each do |permission|
          puts 'cname - '+"#{cname}"
          puts 'permission.permcl.systitle - '+"#{permission.permcl.systitle}"
          puts 'permission.permcl_action.title - '+"#{permission.permcl_action.title}"
          if permission.permcl.systitle.constantize == cname
            can permission.permcl_action.title.to_sym, permission.permcl.systitle.constantize
          else
            can :read, :all
          end
      	end
      end
    #
    #Стандартные соглашения по страницам CRUD в cancan
# 		alias_action :index, :show, :to => :read
# 		alias_action :new, :to => :create
# 		alias_action :edit, :to => :update

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
  end
end
