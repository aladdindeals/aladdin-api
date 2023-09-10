# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
#
# [
#   {
#     partner:                 'Flipkart',
#     domain:                  "https://www.flipkart.com/",
#     scrapping_configuration: YAML::load_file(File.join(Rails.root, 'lib', 'assets', 'scrapping_configurations', 'flipkart.yml')),
#     configurations:          [
#                                { name: "Affliated ID", field: 'affid', value: 'rohanpouri' },
#                                { name: "Affliated Extra Param 1", field: 'affExtParam1', value: 'ENKR20230807A555088582' },
#                                { name: "Affliated Extra Param 2", field: 'affExtParam2', value: 'ENKR20230807A555088582' }
#                              ]
#   },
#   {
#     partner:                 'Amazon',
#     domain:                  'https://www.amazon.in/',
#     scrapping_configuration: YAML::load_file(File.join(Rails.root, 'lib', 'assets', 'scrapping_configurations', 'amazon.yml')),
#     configurations:          [
#                                { name: "Affliated ID", field: 'tag', value: 'earnkaro09e_1886-21' },
#                              ]
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