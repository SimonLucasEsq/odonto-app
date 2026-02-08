require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should have_many(:work_order_items) }
end
