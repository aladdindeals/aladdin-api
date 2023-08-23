class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :partner, foreign_key: true, type: :uuid
      t.references :category, foreign_key: true, type: :uuid
      t.string :pid, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.bigint :total_ratings, default: 0
      t.bigint :total_reviews, default: 0
      t.float :avg_rating, default: 0.0
      t.float :price, default: 0.0
      t.float :maximum_retail_price, default: 0.0
      t.float :offer_percentage, default: 0.0
      t.jsonb :meta_headers, default: {}
      t.timestamps
    end
    add_index :products, [:pid, :partner_id, :category_id], unique: true
  end
end
