class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

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
     @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to GamePlayDate!"
        redirect_to @user
      else
        render 'new'
      end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(params[:user])
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
  private

     def correct_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
     end

     def admin_user
       redirect_to(root_url) unless current_user.role.name = 'admin'
     end
end
