class CollaborationsController < ApplicationController
    
    def create
        
        puts "********PARAMS****"
        puts params
        @wiki = Wiki.find(params[:wiki_id])
        @collaboration = @wiki.collaborations.new
        
        search = params[:search]
        user = User.find_by_email(search)
        
        authorize @collaboration
        
        puts user
        
        if user.nil?
           flash[:alert] = "You have either mispelled the user e-mail or #{search} does not exist in our system. Please try again."
        # if wiki_author OR wiki collaborator
        elsif @wiki.user.id == user.id || @wiki.collaborations.pluck(:user_id).include?(user.id)
           flash[:alert] = "User already a collaborator or owner of this wiki."
        else
            @collaboration.user = user
            @collaboration.wiki = @wiki
            
            if @collaboration.save
                flash[:notice] = "You have successfully added #{user.email} as a collaborator."
            else
                flash[:alert] = "Error when adding e-mail. Please try again."
            end
        end
        
        redirect_to @wiki
        
    end
    
    def destroy
        
        wiki = Wiki.find(params[:wiki_id])
        collaboration = wiki.collaborations.find(params[:id])
        user = User.find(collaboration.user_id)
        
        authorize collaboration
        
        if collaboration.destroy
            flash[:notice] = "User removed from collaboration."
        else
            flash[:alert] = "Unable to remove #{user} from collaboration. Please try again."
        end
        
        redirect_to wiki
        
    end
    
end