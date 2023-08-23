class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners, id: :uuid do |t|
      t.string :name, null: false
      t.text :domain, null: false
      t.boolean :active, default: true
      t.timestamps
    end
    add_index :partners, :name, unique: true
  end
end
