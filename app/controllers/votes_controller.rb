class VotesController < ApplicationController
  before_action :set_listing, only: %i[ create update destroy ]
  before_action :set_vote, only: %i[ update destroy ]

  respond_to :js

  # POST /listings/:listing_id/votes
  def create
    @vote = @listing.votes.new(voting_params)

    if @listing.owner == current_user
      @error = 'You cannot vote your own listing'
    elsif @vote.save
      @error = nil
    else
      @error = full_error_messages(@vote)
    end
  end

  # PATCH/PUT /listings/:listing_id/votes/:id
  def update
    if @listing.owner == current_user
      @error = 'You cannot vote your own listing'
    elsif @vote.update({vote_type: !Vote.vote_types[@vote.vote_type]})
      @error = nil
    else
      @error = full_error_messages(@vote)
    end
  end

  # DELETE /listings/:listing_id/votes/:id
  def destroy
    @error = @vote.destroy ? nil : 'Some error occurred!'
  end

  private

  def set_listing
    @listing = Listing.find_by(id: params[:listing_id])
  end

  def voting_params
    vote_type = params[:vote_type].to_i
    {
      user_id: current_user.id,
      vote_type: vote_type > 1 ? nil : !vote_type.zero?
    }
  end

  def set_vote
    @vote = @listing.votes.find_by(id: params[:id])
  end
end
