class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :check_user_type, only: %i[ create new ]
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ]

  # GET /listings or /listings.json
  def index
    @services = Service.all
    @listings = Listing.includes(:service, :uploads_attachments).all
    @listings = @listings.where(owner_id: params[:u]) if params[:u].present?
    @listings = @listings.where(service_id: params[:s]) if params[:s].present?
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    owner = User.find_by(id: params[:listing][:owner_id].presence) || current_user
    @listing = owner.listings.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
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
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:owner_id, :service_id, :name, :description, :available_on, :price,
      :deleted_at, :meta_description, :meta_keywords, :promotionable, :meta_title, :discontinue_on, :currency,
      :talk_type, :event_time, :event_place, :live_session_time, :live_session_end_time, uploads: []
    )
  end

  def check_user_type
    redirect_to listings_path, notice: 'Unauthorized' if is_fan?
  end

  def check_owner
    redirect_to listing_path(@listing), notice: 'Unauthorized' if @listing.owner != current_user
  end
end
