class CollaborationPolicy < ApplicationPolicy
    attr_reader :user, :collaboration
   
    def initialize(user, collaboration)
        @user = user
        @collaboration = collaboration
    end
    
    # controller policies
    
    def create?
        self.wiki_author? || user.admin? || self.is_collaborator?(self.wiki)
    end
    
    def destroy?
        self.wiki_author? || user.admin?  || self.is_collaborator?(self.wiki)
    end
    
    # view policies
    
    def is_collaborator?(wiki)
        wiki.collaborations.pluck(:user_id).include?(user.id)
    end
    
    def wiki_author?
        wiki = Wiki.find(collaboration.wiki_id)
        wiki.user_id == user.id
    end
    
    def wiki
        Wiki.find(collaboration.wiki_id)
    end
    
end