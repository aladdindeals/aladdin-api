class ProductUrl < ApplicationRecord
  belongs_to :partner
  validates :url, presence: true, format: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/
  enum :scraping_status, [:pending, :processing, :success, :failed]
  enum :url_source, [:manual, :telegram]
  validates_presence_of :channel_name, if: Proc.new { |url| url.url_source_telegram? }
end
