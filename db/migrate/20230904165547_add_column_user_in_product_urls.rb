class AddColumnUserInProductUrls < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_urls, :creator, foreign_key: { to_table: :users }, type: :uuid
    add_column :product_url_mappings, :source_data, :jsonb, default: {}
  end
end
