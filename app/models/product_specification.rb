class ProductSpecification < ApplicationRecord
  belongs_to :product, inverse_of: :product_specifications
  validates_presence_of :name, :description, :group
  validates_uniqueness_of :name, scope: [:group, :product_id]
end
