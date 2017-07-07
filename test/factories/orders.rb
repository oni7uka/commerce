FactoryGirl.define do
  factory :order do
    association :user
  end

  factory :order_with_line_items, parent: :order do
    transient do
      line_items_count 5
    end
    after(:create) do |order, evaluator|
      create_list(:line_item,  evaluator.line_items_count , order: order)
      order.update_totals
    end
  end

  factory :payment_state_order, parent: :order_with_line_items do
    state :payment
  end
end
