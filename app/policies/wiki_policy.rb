class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
    
    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end
    
    def edit?
        user.present? && ( !wiki.private || wiki.user_id == user.id || user.admin? )
    end
    
    def update?
        user.present? && ( !wiki.private || wiki.user_id == user.id || user.admin? )
    end
    
    def destroy?
        wiki.user_id == user.id || user.admin?
    end
    
end