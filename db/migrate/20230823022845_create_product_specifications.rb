class CreateProductSpecifications < ActiveRecord::Migration[7.0]
  def change
    create_table :product_specifications, id: :uuid do |t|
      t.references :product, foreign_key: true, type: :uuid
      t.string :group, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end
    add_index :product_specifications, [:product_id, :name, :group], unique: true
  end
end
