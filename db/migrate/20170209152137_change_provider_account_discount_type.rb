class ChangeProviderAccountDiscountType < ActiveRecord::Migration[5.0]
  def change
    rename_column :provider_accounts, :discount_percentage, :discount_type
  end
end
