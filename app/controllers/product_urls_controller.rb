class ProductUrlsController < ApplicationController
  before_action :set_product_url, only: [:show]

  def index
    @product_urls = ProductUrl.includes(:partner).order(created_at: :desc)
  end

  def new
    @product_url = ProductUrl.new
  end

  def create
    @product_url = ProductUrl.create(product_url_params)
    if @product_url.errors.none?
      flash[:success] = "The URL you've submitted being parsed, please wait for some time."
      redirect_to product_urls_path
    end
  end

  def show

  end

  private

  def product_url_params
    params.require(:product_url).permit(:url, :partner_id)
  end

  def set_product_url
    @product_url = ProductUrl.find_by(id: params[:id])
    return if @product_url.present?
    flash[:error] = "Requested product URL not found."
    redirect_to product_urls_path
  end
end
