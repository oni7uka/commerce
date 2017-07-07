class Payment < ApplicationRecord
  include NumberGenerator
  belongs_to :order, inverse_of: :payment
  belongs_to :payment_method

  state_machine :initial => :waiting do
    # before_transition :waiting => :complated
    # before_transition :waiting => :canceled, :do => :processing
    # before_transition :complated => :refunded, :do => :

    event :complete do
      transition :waiting => :completed
    end

    event :cancel do
      transition :waiting => :canceled
    end

    event :restore do
      transition :canceled => :waiting
    end

    event :refund do
      transition :completed => :refunded
    end
  end

  def generate_number(options = {})
    options[:prefix] ||= "P#{Time.now.to_i.to_s(16).upcase}"
    options[:length] ||= 4
    super(options)
  end
end
