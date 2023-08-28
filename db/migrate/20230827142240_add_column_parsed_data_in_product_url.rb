class AddColumnParsedDataInProductUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :product_urls, :parsed_data, :jsonb, default: {}
  end
end
