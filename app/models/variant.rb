class Variant < ApplicationRecord
  belongs_to :product, inverse_of: :variants
  acts_as_list scope: :product
end
