class LineItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_cart, only: %i[ create ]
  before_action :set_line_item, only: %i[ destroy ]

  # POST /line_items or /line_items.json
  def create
    @line_item = line_item_builder

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.js
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    cart = @line_item.cart
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(cart), notice: 'Item removed from the cart.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:listing_id, :addon_id)
  end

  def line_item_builder
    if params[:listing_id].present?
      item = Listing.find(params[:listing_id])
    elsif params[:addon_id].present?
      item = Addon.find(params[:addon_id])
    else
      item = nil
    end

    @cart.add_item(item)
  end
end
