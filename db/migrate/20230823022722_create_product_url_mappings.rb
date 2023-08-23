class CreateProductUrlMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :product_url_mappings, id: :uuid do |t|
      t.references :product_url, foreign_key: true, type: :uuid
      t.references :product, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
