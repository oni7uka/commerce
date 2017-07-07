class Product < ApplicationRecord
  include Viewable
  belongs_to :category, inverse_of: :products
  has_many :variants, -> { order(position: :asc) }, inverse_of: :product

end
