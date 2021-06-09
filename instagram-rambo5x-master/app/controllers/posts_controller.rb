class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_ownership!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @user.posts.reverse
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = @user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @user.posts.build(post_params)

    if @post.save
        redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
        render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
        redirect_to user_posts_path(@user), notice: 'Post was successfully updated.'
    else
        render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to user_posts_url(@user), notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_post
      @post = @user.posts.find(params[:id])
    end

    def verify_ownership!
      if current_user.id != @user.id
        redirect_to root_path, alert: "You are not authorized to complete this action."
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:caption, :image_url)
    end
end
