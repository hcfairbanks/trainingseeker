class CreateProviderAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :provider_accounts do |t|
      t.references :provider, foreign_key: true
      t.string :merchant_id
      t.string :api_key
      t.integer :discount_percentage

      t.timestamps
    end
  end
end
