class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
  # duplicate model to prevent migration breakage if model ever changes in the future
  class User < ActiveRecord::Base
  end

  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
		add_index :users, :confirmation_token, unique: true

    User.find_each do |user|
      user.confirmed_at = Time.now
      user.save
    end
  end

  def down
		remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
