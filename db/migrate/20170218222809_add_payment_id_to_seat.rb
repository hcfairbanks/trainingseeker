class AddPaymentIdToSeat < ActiveRecord::Migration[5.0]
  def change
    add_reference :seats, :payment, index: true, foreign_key: true
  end
end
