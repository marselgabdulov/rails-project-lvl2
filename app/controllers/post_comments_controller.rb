class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]
  before_action :check_author, only: %i[destroy]

  def create
    @post_comment = @post.post_comments.create(user_id: current_user.id, **post_comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post_comment = @post.post_comments.find(params[:id])
    @post_comment.destroy
    redirect_to post_url(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  endx  

  def check_author
    redirect_to post_path(@post), notice: 'Действие недопустимо. Вы не автор этого комментария.' if @post.post_comments.find(params[:id]).user != current_user
  end

  def post_comment_params
    params.require(:post_comment).permit(:content)
  end

end
