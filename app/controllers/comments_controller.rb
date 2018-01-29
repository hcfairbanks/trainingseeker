class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      #redirect_to post_path(@comment.post_id),  notice: t("comment.successfully-created")
      redirect_to(request.env['HTTP_REFERER'])
    else
      redirect_to post_path(@comment.post_id),  notice: t("comment.not-successfully-created")
    end
  end

  def update
    if @comment.update(comment_params)
      #redirect_to post_path(@comment.post_id), notice: t("comment.successfully-updated")
      redirect_to(request.env['HTTP_REFERER'])
    else
      redirect_to post_path(@comment.post_id), notice: t("comment.not-successfully-updated")
    end
  end

  def destroy
    post_id = @comment.post_id
    if @comment.destroy
      #redirect_to post_path(post_id), notice: t("comment.successfully-destroyed")
      redirect_to(request.env['HTTP_REFERER'])
    else
      redirect_to post_path(post_id), notice: "#{t("comment.not-successfully-destroyed")} #{t("sys_admin")}"
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit( :post_id, :content).merge(user_id: current_user.id)
    end
end
