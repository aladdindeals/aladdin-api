class FetchProductUrlJob < ApplicationJob
  queue_as :default

  def perform(product_url_id)
    product_url = ProductUrl.find_by(id: product_url_id)
    return if product_url.blank?
    Current.product_url = product_url
    Current.product_url.update(scraping_status: :processing, scraping_started_on: Time.zone.now)
    Scrapper.crawl!
  end
end
