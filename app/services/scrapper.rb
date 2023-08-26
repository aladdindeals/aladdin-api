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

  def parse(response, options = {})
    configurations = Current.product_url.partner.affiliated_setting&.scrapping_configuration
    if configurations.present?
      parsed_data = configurations.map do |item|
        parsed_html_nodes = response.xpath(item['xpath']).text.squish
        next if item['database_field'].blank? || parsed_html_nodes.blank?
        [
          item['database_field'],
          Scrapper::DataItem.new(parsed_html_nodes, item).parse
        ]
      end.compact_blank.to_h
      puts parsed_data
    else
      raise "Partner configuration is not found, Please configure !"
    end
  end
end