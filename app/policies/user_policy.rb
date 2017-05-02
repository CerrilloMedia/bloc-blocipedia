class UserPolicy < ApplicationPolicy
   attr_reader :user, :wiki
   
   def initialize(wiki, user)
      @wiki = wiki
      @user = user
   end
   
   def author?(wiki)
      user.id == wiki.user_id
   end
    
   
end