class AffiliateSetting < ApplicationRecord
  belongs_to :partner, inverse_of: :affiliated_setting
end
