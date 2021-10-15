class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user, only: %i[new create edit update destroy]
  before_action :check_author, only: %i[update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def check_author
    redirect_to post_path(@post), notice: 'Действие недопустимо. Вы не автор этого поста.' if @post.user != current_user
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
