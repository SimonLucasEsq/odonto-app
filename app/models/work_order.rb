class WorkOrder < ApplicationRecord
  has_many :work_order_items, dependent: :destroy

  enum :status, { draft: 0, scheduled: 1, in_progress: 2, done: 3, cancelled: 4 }

  validates :status, presence: true
end
