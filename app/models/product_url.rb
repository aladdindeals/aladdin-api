class ProductUrl < ApplicationRecord
  belongs_to :partner
  validates :url, presence: true
  enum :scraping_status, [:pending, :processing, :success, :failed]
  enum :url_source, [:manual, :telegram], _prefix: true
  validates_presence_of :channel_name, if: Proc.new { |url| url.url_source == 'telegram' }
  has_many_attached :product_images
  after_create_commit :fetch!

  def time_taken_in_seconds
    return if scraping_ended_on.blank? || scraping_started_on.blank?
    scraping_ended_on.to_time.to_i - scraping_started_on.to_time.to_i
  end

  def fetch!(async = true)
    if async
      FetchProductUrlJob.perform_later(id)
    else
      FetchProductUrlJob.perform_now(id)
    end
  end
end
