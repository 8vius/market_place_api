require 'spec_helper'

describe Product do
  let(:product) { build(:product) }
  subject { product }

  it { should belong_to(:user) }
  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  it { should_not be_published }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user }
end
