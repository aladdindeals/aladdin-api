class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  scope :most_recently_created, -> { order(created_at: :desc).first }
  scope :earliest_created, -> { order(created_at: :asc).first }
end
