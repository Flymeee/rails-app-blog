class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(@article), notice: "Comment posted!"
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  def edit
  
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: "Comment updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_comments_path(@article), notice: "Comment deleted successfully!"
  end

  private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = @article.comments.find_by(id: params[:id])
      unless @comment
        redirect_to article_path(@article), alert: "Comment doesn't exist or may have been deleted :("
      end
    end

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
