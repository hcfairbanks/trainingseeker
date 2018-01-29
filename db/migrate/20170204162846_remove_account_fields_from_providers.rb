class RemoveAccountFieldsFromProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :providers, :merchant_id
    remove_column :providers, :api_key
    remove_column :providers, :api_key_discount
  end
end
