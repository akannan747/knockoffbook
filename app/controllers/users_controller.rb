class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :send_friend_request]
  before_action :set_session_user

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @feed_posts = (@user.friends.map{|u| u.posts}.flatten + @user.posts)
    @feed_posts.sort_by! {|post| post.created_at}.reverse! 
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user.id != session[:user_id]
      redirect_to @session_user, notice: 'Edit failed, unauthorized access.'
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :root, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.id != session[:user_id]
      redirect_to @session_user, notice: 'Delete failed, unauthorized access.'
    else
      @user.posts.each {|p| p.destroy}
      @user.destroy
      @current_user = nil
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Your account has been deleted.' }
        format.json { head :no_content }
      end
    end
  end

  def send_friend_request
    FriendRequest.create(sender_id: @session_user.id, user_id: @user.id)
    redirect_to @session_user, notice: 'Friend request sent!'
  end

  def accept_friend_request
    sender = User.find(params[:sender_id])
    @session_user.friends << sender
    sender.friends << @session_user
    FriendRequest.find_by(sender_id: params[:sender_id]).destroy
    redirect_to @session_user, notice: 'Friend request accepted!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Get session id information.
    def set_session_user
      if session[:user_id]
        @session_user ||= User.find(session[:user_id])
      else
        @session_user = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :password, :password_confirmation)
    end
end
