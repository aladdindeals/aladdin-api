require 'kimurai'

class Scrapper < Kimurai::Base
  @name   = "infinite_scroll_spider"
  @engine = :selenium_firefox

  def self.crawl!
    @start_urls = [Current.product_url.url]
    super
  end

  def parse(response, options = {})
    configurations = Current.product_url.partner.affiliated_setting&.scrapping_configuration
    if configurations.present?
      parsed_data = configurations.map do |item|
        next if item['database_field'].blank?
        parsed_html_nodes = if item['database_field'] == 'images'
                              response.xpath(item['xpath'])
                            else
                              response.xpath(item['xpath']).text.squish
                            end
        next if parsed_html_nodes.blank?
        if item['database_field'] == 'images'
          image_urls = parsed_html_nodes.map { |itm| itm['src'] }.compact_blank
          Scrapper::Images.new(image_urls).download
          next
        else
          [
            item['database_field'],
            Scrapper::DataItem.new(parsed_html_nodes, item).parse
          ]
        end
      end.compact_blank.to_h
      Current.product_url.update(parsed_data: parsed_data, scraping_status: parsed_data.present? ? :success : :failed, scraping_ended_on: Time.zone.now)
    else
      raise "Partner configuration is not found, Please configure !"
    end
  end
end