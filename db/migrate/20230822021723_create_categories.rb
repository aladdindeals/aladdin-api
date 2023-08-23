class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.references :partner, foreign_key: true, type: :uuid
      t.string :name
      t.string :source_name
      t.ltree :parent_path
      t.timestamps
    end
  end
end
