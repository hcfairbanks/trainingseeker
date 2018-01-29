class AddIsApprovedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_approved, :boolean, null: false, default: false
    add_index  :users, :is_approved
  end
end
