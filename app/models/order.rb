class Order < ApplicationRecord
  include NumberGenerator
  include Content
  include Updater
  include Checkout

  belongs_to :user, inverse_of: :orders
  belongs_to :refunded_by, class_name: 'User', optional: true
  belongs_to :ship_address, class_name: 'Adress', optional: true

  has_many :line_items, inverse_of: :order, dependent: :delete_all
  has_one :payment, inverse_of: :order, dependent: :delete

  accepts_nested_attributes_for :line_items, allow_destroy: true

#  accepts_nested_attributes_for :ship_address

  def generate_number(options = {})
    options[:prefix] ||= "R#{Time.now.to_i.to_s(16).upcase}"
    options[:length] ||= 4
    super(options)
  end

  def payment_required?
    total.to_f > 0.0
  end
end
