class PostsController < ApplicationController
  before_action :get_user, only: [:create, :update, :destroy]
  #before_action :current_user, only: [:create, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts/new
  def new
    if session[:user_id]
      @post = Post.new
    else
      redirect_to root_path, notice: "You must be logged in to create a post!"
    end
  end

  # GET /posts/1/edit
  def edit
    if !session[:user_id]
      redirect_to root_path, notice: "You must be logged in to edit a post!"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params.merge(user_id: session[:user_id]))
    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @user, notice: 'Successfully edited your post!' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    # Get current user.
    def get_user
      @user = User.find(session[:user_id])
    end
end
