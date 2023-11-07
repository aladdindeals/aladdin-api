class HomeController < ApplicationController
  before_action :set_product_url, only: [:show]

  def index
    @partner    = Partner.find_by(name: 'Flipkart')
    @categories = set_categories
    @products   = set_products
  end

  def show

  end

  private

  def set_product_url
    @product_url = ProductUrl.find_by(id: params[:id])
    return if @product_url.present?
    flash[:error] = 'Product is not found'
    redirect_back(fallback_location: root_path)
  end

  def set_categories
    @partner
      .product_urls
      .where(scraping_status: "success")
      .where("parsed_data->>'breadcrumb' is not null")
      .select(Arel.sql("parsed_data->>'breadcrumb' as category_name, count(id) as product_count"))
      .group('1')
      .map do |category|
      begin
        {
          name:  JSON.parse(category['category_name'])[1],
          count: category['product_count']
        }
      rescue
        nil
      end
    end.compact_blank
      .uniq
      .group_by { |i| i[:name] }
      .transform_values { |v| v.pluck(:count).sum }
      .sort_by { |k, v| }
      .reverse
      .first(4)
      .to_h
  end

  def set_products
    @partner
      .product_urls
      .where(scraping_status: "success")
      .order(created_at: :desc)
      .limit(10)
  end
end
