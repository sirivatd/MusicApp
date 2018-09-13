class LinksController < ApplicationController

  before_action :require_login
  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def update
    @link = current_user.links.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.error.full_messages
      redirect_to link_url(@link)
    end
  end

  def edit
    
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.error.full_messages
      redirect_to links_url

    end
  end

  def destroy

  end

  private

  def link_params
    require.(:link).permit(:title, :url, :)
  end
end