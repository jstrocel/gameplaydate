class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :skip_password_attribute, only: :update
  
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    
    @personas = @user.personas.paginate(page: params[:page])
    @games = @user.games.paginate(page: params[:page])
   @friends = @user.friends
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if params[:beta_invitation_token]
       @user = User.new(:beta_invitation_token => params[:beta_invitation_token])
       @user.email = @user.beta_invitation.recipient_email 
    else
       @user = User.new()
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
     @user = User.new(user_params)
     @user.role = "beta_user" if CONFIG[:beta_mode] ==true
    
      if @user.save
        sign_in @user
        Notifier.registration_confirmation(@user).deliver
        flash[:success] = "Welcome to GamePlayDate!"
        redirect_to root_path
      else
        render 'new'
      end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  
  
  
  private
  
      def user_params
      
          allowed_attributes = [ :name, :email, :friend_ids, :pending_friend_ids, :password, :password_confirmation, :user, :beta_invitation_token]
        params.require(:user).permit(allowed_attributes)
      end
      
      
      def skip_password_attribute
        if params[:password].blank? && params[:password_confirmation].blank?
          params.except!(:password, :password_confirmation)
        end
      end
  

     def correct_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
     end

     def admin_user
       redirect_to(root_url) unless current_user.admin?
     end
end
