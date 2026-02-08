require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:work_order_items) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(1) }
  end

  describe 'factories' do
    it 'builds a valid article' do
      expect(build(:article)).to be_valid
    end
  end
end
