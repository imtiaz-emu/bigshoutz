class CommentsController < ApplicationController
  before_action :set_listing
  before_action :set_comment, only: %i[ edit update destroy ]

  respond_to :js

  # GET /listings/:listing_id/comments/:id
  def edit; end

  # POST /listings/:listing_id/comments
  def create
    @comment = @listing.comments.new(comment_params)
    @comment.user = current_user

    @error = @comment.save ? nil : full_error_messages(@comment)
    load_comments
  end

  # PATCH/PUT /listings/:listing_id/comments/:id
  def update
    @error = @comment.update(comment_params) ? nil : full_error_messages(@comment)
    load_comments
  end

  # DELETE /listings/:listing_id/comments/:id
  def destroy
    @error = @comment.destroy ? nil : 'Some error occurred!'
    load_comments
  end

  private

  def set_listing
    @listing = Listing.find_by(id: params[:listing_id])
  end

  def comment_params
    params.require(:comment).permit(:description)
  end

  def set_comment
    @comment = @listing.comments.find_by(id: params[:id])
  end

  def load_comments
    @comments = @listing.comments
  end
end
