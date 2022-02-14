class VotesController < ApplicationController
  before_action :set_listing, only: %i[ create update destroy ]
  # before_action :check_owner, only: %i[ edit update destroy ]

  respond_to :js

  # POST /listings or /listings.json
  def create
    @vote = @listing.votes.new(voting_params)

    if @listing.owner == current_user
      @error = 'You cannot vote your own listing'
    elsif @vote.save
      @error = nil
    else
      @error = @vote.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def voting_params
    vote_type = params[:vote_type].to_i
    {
      user_id: current_user.id,
      vote_type: vote_type > 1 ? nil : !vote_type.zero?
    }
  end

  def check_owner
    redirect_to listing_path(@listing), notice: 'Unauthorized' if @listing.owner != current_user
  end

  def check_profile_data_missing
    if !is_admin? && incomplete_profile?
      redirect_to edit_profile_path(current_profile), notice: 'Complete your profile!'
    end
  end
end
