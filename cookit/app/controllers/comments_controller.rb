class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_commentable
  
  def index
    if params[:id]
      @comments = Comment.where("id > ?", params[:id]).limit(5)
    else
      @comments = Comment.limit(5)
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to :back, notice: "Your comment wasn't posted!"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Recipe.find_by(id: params[:recipe_id]) if params[:recipe_id].present?
    end
end
