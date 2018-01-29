authorization do
  role :admin do
    has_permission_on [:mainpages, :users,:roles,:posts,:comments], :to => [:serve,:index, :show, :new, :create, :edit, :update, :destroy]
  end
  role :user do
    has_permission_on [:posts], :to => [:index, :show, :new, :create]
    has_permission_on [:posts], :to => [:edit, :update, :destroy]do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:comments], :to => [:index, :show, :new, :create]
    has_permission_on [:comments], :to => [:edit, :update, :destroy]do
      if_attribute :user_id => is { user.id }
    end


    #has_permission_on [:users], :to => [:serve ]

     #used this line to test the new permissions in the index view.
     # it is restricted to admin only
     #has_permission_on [:users], :to => [:index, :show, :edit, :update, :destroy] do

    has_permission_on [:users], :to => [:serve, :show, :edit, :update, :destroy] do
      if_attribute :id => is { user.id }
    end
  end

   role :guest do
      has_permission_on [:users], :to => [:new, :create,]
  #   has_permission_on [:users], :to => [:show, :edit, :update, :destroy]
  #   has_permission_on :articles, :to => [:index, :show]
  #   has_permission_on :comments, :to => [:new, :create]
  #   has_permission_on :comments, :to => [:edit, :update] do
  #     if_attribute :user => is { user }
  #   end
   end

  # role :moderator do
  #   includes :guest
  #   has_permission_on :comments, :to => [:edit, :update]
  # end

  # role :author do
  #   includes :guest
  #   has_permission_on :articles, :to => [:new, :create]
  #   has_permission_on :articles, :to => [:edit, :update] do
  #     if_attribute :user => is { user }
  #   end
  # end
end
