class ProductUrl::Product
  attr_accessor :product_url

  def initialize(product_url)
    @product_url = product_url
  end

  def create_product!
    ApplicationRecord.transaction do
      find_or_create_category!
      source_data = product_url.parsed_data
      @product    = product_url.partner.products.find_or_create_by(pid: source_data['pid'], name: source_data['name'], description: source_data['description'].to_s)
      if @product.errors.none?
        meta_headers               = {}
        meta_headers[:title]       = source_data.dig('meta_title') if source_data.dig('meta_title').present?
        meta_headers[:description] = source_data.dig('meta_description') if source_data.dig('meta_description').present?
        meta_headers[:keywords]    = source_data.dig('meta_keywords') if source_data.dig('meta_keywords').present?
        @product.update(
          total_ratings:        source_data['total_ratings'].to_i,
          total_reviews:        source_data['total_reviews'].to_i,
          avg_rating:           source_data['avg_rating'].to_f,
          price:                source_data['price'].to_f,
          maximum_retail_price: source_data['maximum_retail_price'].to_f,
          offer_percentage:     source_data['offer_percentage'].to_f,
          meta_headers:         meta_headers,
          category_id:          @category&.id
        )
      end
    end
    attach_images!
  end

  private

  def find_or_create_category!
    @category = nil
  end

  def attach_images!
    return unless product_url.product_images.attached?
    product_url.product_images.each do |product_image|
      next if product_image.blob.blank?
      @product.images.attach(product_image.blob)
    end
  end
end