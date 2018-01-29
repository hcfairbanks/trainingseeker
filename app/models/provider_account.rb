class ProviderAccount < ApplicationRecord
  belongs_to :provider

  enum discount_type: {regular: 0, discounted: 1}
end
