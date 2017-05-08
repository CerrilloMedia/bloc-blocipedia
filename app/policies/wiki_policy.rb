class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
    
    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end
    
    def destroy?
        self.author? || user.admin?
    end
    
    # non view-related methods
    
    def author
        User.find(@wiki.user_id)
    end
    
    def author?
        wiki.user_id == user.id
    end
    
    def editable?
        !wiki.private? || self.author? || user.admin? || user.premium?
    end
    
end