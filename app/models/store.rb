class Store < ApplicationRecord
  has_many :store_products
  has_many :products, through: :store_products
  validates :name, :address, presence: true
end
