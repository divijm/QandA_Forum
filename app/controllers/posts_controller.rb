class PostsController < ApplicationController
before_action :find_post, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @new_comment = @post.comments.build
    @comments = @post.comments
  end

  def new
    # @post = Post.new -- Why did he do this?!
    @post = current_user.posts.build
  end

  def create
    # @post = Post.new(post_params) -- Same situ here brah!
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
