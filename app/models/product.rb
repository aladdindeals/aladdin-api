class Product < ApplicationRecord
  belongs_to :partner, inverse_of: :product
  belongs_to :category, inverse_of: :product
  has_many :product_specifications, inverse_of: :product
  has_many_attached :images

  validates :pid, presence: true, uniqueness: { scope: [:partner_id, :category_id] }
  validates_presence_of :name, :description
end
