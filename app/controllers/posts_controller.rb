class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
    flash[:alert] = "You do not own this post therefore you cannot edit it"
    redirect_to posts_path(@post)
    end
  end
  redirect_to_posts_path
  def new
    @post = Post.new
  end
  def create
    @post = Post.create!(post_params.merge(user: current_user))
    redirect_to post_path(@post)
  end
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.user  == current_user
       @post.destroy
    else flash[:alert] = "You do not own this post and can't delete"
    end
    redirect_to posts_path
  end
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
