class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store
  validates :price, presence: true, numericality: { greater_than: 0 }
end
