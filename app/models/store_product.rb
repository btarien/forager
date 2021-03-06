class StoreProduct < ApplicationRecord
  include PgSearch::Model

  belongs_to :product
  belongs_to :store
  validates_uniqueness_of :product, scope: :store

  pg_search_scope :global_search,
    associated_against: {
      product: [:category]
    },
    using: {
      tsearch: { prefix: true }
    }

  def self.hash_of_store_products
    product_hash = {}

    if params[:query].present?
      @store_products = StoreProduct.global_search(params[:query])
    end

    StoreProduct.all.each do |store_product|
      if product_hash.keys.include? store_product.product
        product_hash[store_product.product] << store_product.store
      else
        product_hash[store_product.product] = [store_product.store]
      end
    end
    product_hash
  end
end
