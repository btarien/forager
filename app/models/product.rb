class Product < ApplicationRecord
  has_many :store_products
  has_many :stores, through: :store_products
  has_many :favorites
  has_many :groceries, through: :store_products

  validates :name, :brand, :nutriscore, presence: true

  def favorite?(user)
    user.favorites.where(product: self).any?
  end
end
