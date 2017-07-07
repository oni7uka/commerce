class Category < ApplicationRecord
  has_many :products, inverse_of: :category
  acts_as_nested_set
end
