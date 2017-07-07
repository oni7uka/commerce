class PaymentMethod < ApplicationRecord

  scope :actived, ->{ where(active: true) }

  class << self
    def default
      @_default = PaymentMethod.actived.find_by(default: true)
      @_default.nil? ? PaymentMethod.actived.first : @_default
    end
  end
end
