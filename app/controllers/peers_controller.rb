class PeersController < ApplicationController
  before_action :registered_peer, only: [:edit, :update]
  before_action :correct_peer,   only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :has_account, only: [:new, :create]

  def index
    @peers = Peer.order('name ASC')
  end

  def new
  	@peer = Peer.new
    session[:peer_step] = @peer.current_step
  end

  def show
  	@peer = Peer.find(params[:id])
  end

  def create
  	@peer = Peer.new(peer_params)
    if @peer.save
      register @peer
      redirect_to registration_peer_path(current_peer)
      @peer.next_step
      session[:peer_step] = @peer.current_step

      mailchimp.lists.subscribe({:id => p2pc_list_id, :email => {:email => @peer.email}, :merge_vars => {:FNAME => @peer.name}, :double_optin => false, :send_welcome => true})
    else
      render 'new'
    end
  end

  def registration
    @peer = current_peer
    @peer.current_step = session[:peer_step]
  end

  def edit
  end

  def update
    @peer.current_step = session[:peer_step]
    old_email = @peer.email
    old_name = @peer.name

    if @peer.update_attributes(peer_params)
      if old_email != @peer.email || old_name != @peer.name
        mailchimp.lists.subscribe({:id => p2pc_list_id, :email => {:email => old_email}, :merge_vars => {:FNAME => @peer.name, :EMAIL => @peer.email}, :update_existing => true})
      end
      if params[:submit_button]
        redirect_to thanks_path
        forget_peer
        reset_session
      else
        if params[:back_button]
          @peer.previous_step
        else
          @peer.next_step
        end
        redirect_to registration_peer_path(current_peer)
        session[:peer_step] = @peer.current_step
      end
    else
      render 'registration'
    end
  end

  def destroy
    Peer.find(params[:id]).destroy
    flash[:success] = "Peer destroyed."
    redirect_to peers_url
  end

  private

  def peer_params
  	params.require(:peer).permit(:name, :email, :availability_location, {availability_time: []}, :availability_team, :startup_info, :startup_role, :startup_market, :startup_persona, :startup_time, :startup_interviews, :startup_customers, :startup_pmf, :startup_metrics, {startup_stage: []}, :startup_stage, :runway_desc, :runway_milestone, :runway_constraints)
  end

  # Before filters

  def correct_peer
    @peer = Peer.find(params[:id])
    redirect_to(root_url) unless current_peer?(@peer)
    flash[:warning] = "You can't see that!" if !current_peer?(@peer)
  end

 # def admin_user
 #     redirect_to(users_url) unless current_user.admin?
 #     redirect_to(users_url) if User.find(params[:id]) == current_user
 # end

  def has_account
    if registered?
      redirect_to(root_url)
      flash[:warning] = "You are already registered!"
    end
  end
end