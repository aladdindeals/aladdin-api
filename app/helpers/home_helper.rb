module HomeHelper

  def pluralize_category(product_count)
    [
      product_count,
      "Product".pluralize(product_count),
      "available"
    ].join(' ')
  end
end
