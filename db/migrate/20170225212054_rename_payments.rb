class RenamePayments < ActiveRecord::Migration[5.0]
  def up
    rename_table('payments', 'purchases')
    rename_column(:seats, :payment_id, :purchase_id)
  end

  def down
    rename_column(:seats, :purchase_id, :payment_id)
    rename_table('purchases', 'payments')
  end
end
