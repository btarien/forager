class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  include PgSearch::Model
  pg_search_scope :global_search,
    associated_against: {
      product: [ :name]
    },
    using: {
      tsearch: { prefix: true }
    }
end
