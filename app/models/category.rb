class Category < ApplicationRecord
  belongs_to :partner, inverse_of: :categories
  has_many :products, inverse_of: :categories
  validates_presence_of :source_name, :name
  # before_save :set_source_name, on: :create
  
  ltree :parent_path

  def children
    self.partner.categories.where(parent_path: [self.parent_path, self.source_name].join('.'))
  end

  def parent
    # todo: change
    parent_root_path = self.parent_path.to_s.split('.')
    if parent_root_path.size > 1
      self.partner.categories.find_by(parent_path: parent_root_path[0..-2].join('.'), source_name: parent_root_path.last)
    else
      self.partner.categories.find_by(parent_path: parent_root_path[0])
    end
  end

  private

  def set_source_name
    return if source_name.present?
    self.source_name = self.name.downcase.parameterize(separator: '_')
  end
end
