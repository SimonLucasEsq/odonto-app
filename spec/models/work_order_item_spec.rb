require 'rails_helper'

RSpec.describe WorkOrderItem, type: :model do
  it { should belong_to(:work_order) }
  it { should belong_to(:article) }
  it { should validate_presence_of(:article) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
end
