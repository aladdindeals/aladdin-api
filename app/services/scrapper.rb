require 'kimurai'

class Scrapper < Kimurai::Base
  @name   = "infinite_scroll_spider"
  @engine = :selenium_firefox

  def self.crawl!
    @start_urls = [Current.product_url.url]
    super
  end

  def self.open_spider
    Current.product_url.update(scraping_status: :processing)
  end

  def self.close_spider
    Current.product_url.update(scraping_status: :success)
  end

  def parse(response, **options)
  end
end