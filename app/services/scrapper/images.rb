require 'open-uri'
require "down"
require "fileutils"

class Scrapper::Images
  def initialize(urls)
    @urls = [urls].flatten.compact_blank
  end

  def download
    return if @urls.blank?
    Current.product_url.product_images.destroy_all
    @urls.each_with_index do |url, index|
      file_name = "#{url.split('/').last.truncate(28)}_#{index}.jpeg"
      begin
        @temp_file = Down.download(
          url,
          max_redirects: 5,
          max_size:      5 * 1024 * 1024
        )

        Current.product_url.product_images.attach(io: File.open(@temp_file.path), filename: file_name, content_type: 'image/jpeg')
      rescue
        nil
      end
      @temp_file.close!
    end
  end

  private

  def download_image(url)
    @temp_file.binmode

    @temp_file.write open(url).read
    @temp_file.path
  end
end