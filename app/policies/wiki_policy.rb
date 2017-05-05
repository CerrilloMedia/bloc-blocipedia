class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
    
    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end
    
    # def show?
    #     editable?
    # end
    
    # def edit?
    #     editable?
    # end
    
    # def update?
    #     editable?
    # end
    
    def destroy?
        self.author? || user.admin?
    end
    
    # non view-related methods
    
    def author?
        wiki.user_id == user.id
    end
    
    def editable?
        self.author? || user.admin? || !wiki.private?
    end
    
end