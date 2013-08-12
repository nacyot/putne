class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ownership, only: [:edit, :update, :destroy]
  
  # GET /posts
  def index
    #@posts = Post.all.page(params[:page]).per(1)
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    #redirect_to posts_url, notice: 'Post was successfully destroyed.'
    redirect_to posts_blog_path
  end

  def blog
    @posts = Post.all.order("updated_at DESC").page(params[:page]).per(5)
    @comment = Comment.new
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :title, :entry)
    end

    def ownership
      redirect_to root_path if Post.find(params[:id]).user.id != current_user.id
    end
end
