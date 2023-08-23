class CreateAffiliateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :affiliate_settings, id: :uuid do |t|
      t.references :partner, foreign_key: true, type: :uuid
      t.jsonb :configurations, default: {}
      t.jsonb :scrapping_configuration, default: {}
      t.timestamps
    end
  end
end
