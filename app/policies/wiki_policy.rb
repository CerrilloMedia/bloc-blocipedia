class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
    
    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end
    
    def create?
         (user.premium? || user.admin?) && wiki.private? || !wiki.private?
    end
    
    def destroy?
        self.author? || user.admin?
    end
    
    # non view-related methods
    
    def author
        User.find(wiki.user_id)
    end
    
    def author?
        wiki.user_id == user.id
    end
    
    def is_collaborator?
        wiki.collaborations.pluck(:user_id).include?(user.id)
    end
    
    def can_edit?
        !wiki.private? || (  self.author? || user.admin? || self.is_collaborator? )
    end
    
    class Scope
        attr_reader :user, :scope
        
        def initialize(user, scope)
           @user = user
           @scope = scope
        end
        
        def resolve
            wikis = []
            if user.role == 'admin'
                wikis = scope.all
            elsif user.role == 'premium'
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if wiki.user_id == user.id || wiki.collaborations.pluck(:user_id).include?(user.id) || !wiki.private?
                        wikis << wiki
                    end
                end
            else
                all_wikis = scope.all
                wikis = []
                all_wikis.each do |wiki|
                    if !wiki.private? || wiki.collaborations.pluck(:user_id).include?(user.id)
                        wikis << wiki
                    end
                end
            end
            wikis
        end 
        
    end
end