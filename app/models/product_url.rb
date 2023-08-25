class ProductUrl < ApplicationRecord
  belongs_to :partner
  validates :url, presence: true
  enum :scraping_status, [:pending, :processing, :success, :failed]
  enum :url_source, [:manual, :telegram], _prefix: true
  validates_presence_of :channel_name, if: Proc.new { |url| url.url_source == 'telegram' }
end
