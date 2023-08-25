class Partner < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_presence_of :domain
  has_one :affiliated_setting, inverse_of: :partner, class_name: 'AffiliateSetting'
  has_many :categories, inverse_of: :partner
  has_many :products, inverse_of: :partner
  has_many :product_urls, inverse_of: :partner
end
