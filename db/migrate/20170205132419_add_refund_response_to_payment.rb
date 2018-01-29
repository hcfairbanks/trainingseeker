class AddRefundResponseToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :refund_response, :text
  end
end
