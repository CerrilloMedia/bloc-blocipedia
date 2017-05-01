class UserPolicy < ApplicationPolicy
   attr_reader :user, :wiki
   
   def initialize(wiki, user)
      @wiki = wiki
      @user = user
   end
   
end