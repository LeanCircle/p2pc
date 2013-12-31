class GroupsController < ApplicationController

  def index
    @groups = Group.approved
    @gmaps_hash = Gmaps4rails.build_markers(@groups) do |group, marker|
      marker.lat group.latitude
      marker.lng group.longitude
    end
  end

  def new
    @group = Group.new
  end

  def create
    redirect_to groups_path if params[:commit].eql?('Cancel')
    @group = Group.new(post_params)
    if @group.try(:save)
      UserMailer.group_application(@group).deliver
      flash[:success] = "Your group still needs to be approved. A human will check it shortly!"
      redirect_to groups_path
    else
      render :action => "new"
    end
  end

  private
    def post_params
      params.require(:group).permit(:name,
                                    :city,
                                    :province,
                                    :country,
                                    :meetup_link,
                                    :facebook_link,
                                    :googleplus_link,
                                    :linkedin_link,
                                    :twitter_link,
                                    :other_link)
    end

end