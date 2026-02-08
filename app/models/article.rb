class Article < ApplicationRecord
  has_many :work_order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
