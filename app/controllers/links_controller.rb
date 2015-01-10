class LinksController < ApplicationController

  load_and_authorize_resource

  def index
    @links = Link.where(created_at: Date.today.beginning_of_week(:sunday)..(Time.now)).order(:cached_weighted_score => :desc)
    if current_user
      seen = current_user.votes.votables.sort_by { |k| k["cached_weighted_score"] }.reverse
      @links = (@links - seen) + seen
    end
  end

  def show
    @link = Link.find(params[:id])
    render layout: 'link'
  end

  def new
    @link = Link.new
  end

  def create
    redirect_to links_path and return if params[:commit].eql?('Cancel')
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.try(:save)
      @link.liked_by current_user
      flash[:success] = "Success! Your link was posted."
      redirect_to links_path
    else
      render :action => "new"
    end
  end

  def upvote
    @link = Link.find(params[:link_id])
    @link.liked_by current_user
    redirect_to links_path
  end

  def downvote
    @link = Link.find(params[:link_id])
    @link.disliked_by current_user
    redirect_to links_path
  end

  private
    def link_params
      params.require(:link).permit(:title,
                                   :url,
                                   :reason)
    end

end