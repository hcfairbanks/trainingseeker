class FixProviderFields < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :merchant_id, :string
    add_column :providers, :api_key, :string
    add_column :providers, :api_key_discount, :string

    remove_column :providers, :key1
    remove_column :providers, :key2
  end
end
