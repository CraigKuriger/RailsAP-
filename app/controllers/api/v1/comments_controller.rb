class Api::V1::CommentsController < ApplicationController
  def create
    unless calf = Calf.find_by_id(params[:calf_id])
      render status: 404, json: { error: 'requested calf does not exist' } and return
    end
    review = calf.comments.new(comment_params)
    if comment.save
      render json: comment.as_json(except: [:updated_at, :item_id])
    else 
      render status: 400, json: { errors: comment.errors.full_messages }
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:title, :body, :rating)
    end
end
