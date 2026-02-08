class WorkOrderItem < ApplicationRecord
  belongs_to :work_order
  belongs_to :article

  validates :article, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
