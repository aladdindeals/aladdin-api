require 'open-uri'
require 'uri'
require 'watir'

class ScrapperV3
  class << self
    def crawl!
      browser = Watir::Browser.new :firefox
      browser.goto Current.product_url.url
      begin
        raw_response = browser.html
        response     = Nokogiri::HTML.parse(raw_response)
        parse(response, { url: Current.product_url.url })
      rescue => e
        puts e.message
      end
      browser.close
    end

    def parse(response, options = {})
      configurations = Current.product_url.partner.affiliated_setting&.scrapping_configuration
      if configurations.present?
        parsed_data = configurations.map do |item|
          next if item['database_field'].blank?
          parsed_html_nodes = if item['database_field'] == 'images'
                                response.xpath(item['xpath'])
                              elsif item['from_url'].present?
                                if item['url_pattern'].present?
                                  options[:url].to_s.scan(Regexp.new(item['url_pattern']))&.flatten&.join('').to_s
                                else
                                  query_params = extract_query_params(options[:url].to_s)
                                  query_params.dig(item['query_parameter']).to_s
                                end
                              else
                                response_items = response.xpath(item['xpath']).map do |child|
                                  if item['attribute'].present?
                                    begin
                                      child[item['attribute']]
                                    rescue
                                      child.text.squish
                                    end
                                  else
                                    child.text.squish
                                  end
                                end
                                if item['type'] == 'array'
                                  response_items
                                else
                                  response_items.join(' ')
                                end

                              end
          next if parsed_html_nodes.blank?
          if item['database_field'] == 'images'
            image_urls = parsed_html_nodes.map do |itm|
              if itm.try(:children).present?
                itm.try(:children).map { |child| child['src'] }.compact_blank
              else
                itm['src']
              end

            end.compact_blank.flatten
            Scrapper::Images.new(image_urls).download
            next
          else
            [
              item['database_field'],
              Scrapper::DataItem.new(parsed_html_nodes, item).parse
            ]
          end
        end.compact_blank.to_h
        parsed_data.merge!(query_params: extract_query_params(options[:url].to_s))
        Current.product_url.update(parsed_data: parsed_data, scraping_status: parsed_data.present? ? :success : :failed, scraping_ended_on: Time.zone.now)
      else
        raise "Partner configuration is not found, Please configure !"
      end
    end

    def extract_query_params(url_string)
      uri = URI.parse(url_string)
      begin
        URI.decode_www_form(uri.query).to_h
      rescue
        {}
      end
    end
  end
end