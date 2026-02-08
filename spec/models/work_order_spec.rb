require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  it { should validate_presence_of(:status) }
  it do
    should define_enum_for(:status).
      with_values(%i[draft scheduled in_progress done cancelled]).
      backed_by_column_of_type(:integer)
  end
  it { should have_many(:work_order_items) }
end
