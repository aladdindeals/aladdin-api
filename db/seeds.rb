# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# [
#   {
#     partner:                 'Flipkart',
#     domain:                  "https://www.flipkart.com/",
#     scrapping_configuration: [
#                                { name: "Product Name", database_field: 'name', class: 'B_NuCI', tag: 'span' },
#                                { name: "Average Rating in Star", database_field: 'avg_rating', class: '_3LWZlK', tag: 'div' },
#                                { name: "Ratings", database_field: 'total_ratings', class: '_2_R_DZ', tag: 'span', pattern: "/(\d+(?:,\d+)?)\s*(\w+)/", pattern_key: "ratings", ruby_regex_method: 'scan' },
#                                { name: "Reviews", database_field: 'total_reviews', class: '_2_R_DZ', tag: 'span', pattern: "/(\d+(?:,\d+)?)\s*(\w+)/", pattern_key: "reviews" },
#                                { name: "Current Price", database_field: 'price', class: '_3LWZlK', tag: 'div', pattern: "/\d+$/" },
#                                { name: "MRP", database_field: 'maximum_retail_price', class: '_2p6lqe', tag: 'div', pattern: "/\d+$/" },
#                                { name: "Offer %", database_field: 'offer_percentage', class: '_31Dcoz', tag: 'div', pattern: "/(\d+(?:\.\d+)?)/" },
#                                { name: "Description", database_field: 'description', class: '_1mXcCf RmoJUa', tag: 'div' },
#                                { name: "Images", database_field: 'images', class: 'CXW8mj _3nMexc', tag: 'div', attachment: true },
#                                { name: "Product ID", database_field: 'pid', from_url: true }, # choose another way
#                              ],
#     configurations:          [
#                                { name: "Affliated ID", field: 'affid', value: 'rohanpouri' },
#                                { name: "Affliated Extra Param 1", field: 'affExtParam1', value: 'ENKR20230807A555088582' },
#                                { name: "Affliated Extra Param 2", field: 'affExtParam2', value: 'ENKR20230807A555088582' }
#                              ]
#   },
#   {
#     partner:        'Amazon',
#     domain:         'https://www.amazon.in/',
#     scrapping_configuration:
#                     [
#                       { name: "Product Name", database_field: 'name', class: 'a-size-large product-title-word-break', tag: 'span' },
#                       { name: "Average Rating in Star", database_field: 'avg_rating', class: 'a-size-base a-color-base', tag: 'div' },
#                       { name: "Ratings", database_field: 'total_ratings', class: 'a-size-base', pattern: "/\d+$/", pattern_key: "ratings", tag: 'span' },
#                       { name: "Reviews", database_field: 'total_reviews', class: 'a-row a-spacing-medium averageStarRatingNumerical', tag: 'div', pattern: "/\d+$/" },
#                       { name: "Current Price", database_field: 'price', class: 'hk-umcCard__wrapper', tag: 'div', pattern: "/\d+$/" },
#                       { name: "MRP", database_field: 'maximum_retail_price', class: 'a-price a-text-price', tag: 'div', pattern: "/\d+$/" },
#                       { name: "Offer %", database_field: 'offer_percentage', class: 'a-size-large a-color-price savingPriceOverride aok-align-center reinventPriceSavingsPercentageMargin savingsPercentage', tag: 'div', pattern: "/(\d+(?:\.\d+)?)/" },
#                       { name: "Description", database_field: 'description', class: 'a-unordered-list a-vertical a-spacing-mini', tag: 'ul', child: true },
#                       { name: "Images", database_field: 'images', class: 'imgTagWrapper', tag: 'div', attachment: true },
#                       { name: "Product ID", database_field: 'pid', from_url: true }, # choose another way
#                     ],
#     configurations: [
#                       { name: "Affliated ID", field: 'tag', value: 'earnkaro09e_1886-21' },
#                     ]
#   }
# ].each do |partner_details|
#   partner = Partner.find_or_create_by(name: partner_details[:partner], domain: partner_details[:domain])
#   if partner.errors.none?
#     setting = partner.build_affiliated_setting(
#       configurations:          partner_details[:configurations],
#       scrapping_configuration: partner_details[:scrapping_configuration],
#     )
#     setting.save
#   end
# end

[
  {
    url:     "https://www.flipkart.com/realme-11-pro-5g-oasis-green-256-gb/p/itm5647cce338e55?pid=MOBGPU8H9KVVVHMS&lid=LSTMOBGPU8H9KVVVHMSM5WQKX&marketplace=FLIPKART&store=tyy%2F4io&srno=b_1_1&otracker=clp_metro_expandable_1_5.metroExpandable.METRO_EXPANDABLE_Realme_mobile-phones-store_Q1PDG4YW86MF_wp3&fm=neo%2Fmerchandising&iid=e7225c2c-4f09-4de9-8984-b8845ed0e495.MOBGPU8H9KVVVHMS.SEARCH&ppt=clp&ppn=mobile-phones-store&ssid=vamdnjyb1s0000001692807164780",
    partner: 'Amazon'
  }
].each do |product_url|
  ProductUrl.create(url: product_url[:url], partner: Partner.find_by(name: product_url[:partner]))
end