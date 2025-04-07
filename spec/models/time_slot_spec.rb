require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  subject { build(:time_slot) }

  # Associations
  it { should have_many(:reservations).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  it "should have a duration of 2 hours" do
    slot = build(:time_slot, start_time: "10:00", end_time: "12:00")
    expect(slot.end_time - slot.start_time).to eq(2.hours)
  end

  it "is invalid if end_time is before start_time" do
    slot = build(:time_slot, start_time: "12:00", end_time: "10:00")
    expect(slot).not_to be_valid
  end
end
