class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_post_category, only: %i[new edit]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :check_author, only: %i[edit update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = Post.new(user_id: current_user.id, **post_params)
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

  def set_post_category
    @post_categories = PostCategory.all
  end

  def check_author
    redirect_to post_path(@post), notice: 'Действие недопустимо. Вы не автор этого поста.' if @post.user != current_user
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
