class UserPolicy < ApplicationPolicy
   attr_reader :user, :wiki
   
   def initialize(wiki, user)
      @wiki = wiki
      @user = user
   end
   
   def is_author?
      @wiki.user_id == user.id
   end
   
   
end