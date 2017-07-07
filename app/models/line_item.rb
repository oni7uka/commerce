class LineItem < ApplicationRecord
  belongs_to :variant
  belongs_to :order, inverse_of: :line_items
  validates_numericality_of :quantity, greater_than: 0
end
