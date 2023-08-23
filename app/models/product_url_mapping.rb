class ProductUrlMapping < ApplicationRecord
  belongs_to :product
  belongs_to :product_url
end
