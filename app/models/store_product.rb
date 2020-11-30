class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  def self.hash_of_store_products
    product_hash = {}
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
