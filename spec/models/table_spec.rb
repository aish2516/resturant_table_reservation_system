require 'rails_helper'

RSpec.describe Table, type: :model do
  # subject { build(:table) }
  subject { described_class.new(table_number: 1, capacity: 4, location: "indoor") }

  # Associations
  it { should have_many(:reservations).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:table_number) }
  it { should validate_presence_of(:capacity) }
  it { should validate_presence_of(:location) }

  it { should validate_numericality_of(:table_number).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:capacity).only_integer.is_greater_than(0) }
  it { should validate_uniqueness_of(:table_number) }

  it "should not allow duplicate table numbers" do
    create(:table, table_number: 1)
    table = build(:table, table_number: 1)
    expect(table).not_to be_valid
  end
end
