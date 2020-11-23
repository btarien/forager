class Grocery < ApplicationRecord
  belongs_to :user
  belongs_to :store_product
  has_one :store, through: :store_product
  has_one :product, through: :store_product
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :store_product, uniqueness: true
end
