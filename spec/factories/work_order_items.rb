FactoryBot.define do
  factory :work_order_item do
    association :work_order
    association :article
    quantity { 1 }
  end
end
