class CreateProductUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :product_urls, id: :uuid do |t|
      t.text :url, null: false
      t.references :partner, foreign_key: true, type: :uuid
      t.integer :scraping_status, default: 0
      t.datetime :scraping_started_on
      t.datetime :scraping_ended_on
      t.integer :url_source, default: 0
      t.string :channel_name
      t.text :failure_reason
      t.timestamps
    end
  end
end
