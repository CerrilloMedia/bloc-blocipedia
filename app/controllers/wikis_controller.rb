class WikisController < ApplicationController
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user if current_user
    
    if @wiki.save
      flash[:notice] = "Wiki succesfully saved"
      redirect_to @wiki
    else
      flash.now[:alert] = "Error creating Wiki. Please try again."
      render :new
    end
    
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    # load the instance variable
    @wiki = Wiki.find(params[:id])
    
    # add expected data through wiki_params
    @wiki.assign_attributes(wiki_params)
    
    # Pundit request for update? in WikiPolicy
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki succesfully saved"
      redirect_to @wiki
    else
      flash.now[:alert] = "Error updating Wiki. Please try again."
      render :new
    end
    
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    
    authorize @wiki
    
    if @wiki.delete
      flash[:notice] = "Wiki [#{ @wiki.title }] succesfully deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "Unable to delete. Please try again."
      render :show
    end
    
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
