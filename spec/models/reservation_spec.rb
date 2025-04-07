require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:table) { Table.create!(table_number: 1, capacity: 4, location: 'indoor') }
  let(:customer) { Customer.create!(name: "Test", email: "test@example.com", phone: "1234567890") }
  let(:time_slot) { TimeSlot.create!(label: "10-12", start_time: "10:00", end_time: "12:00") }

  it "is valid with valid attributes" do
    reservation = Reservation.new(
      table: table,
      customer: customer,
      time_slot: time_slot,
      reserved_date: Date.today,
      guest_count: 2
    )
    expect(reservation).to be_valid
  end

  it "is invalid if guest count exceeds table capacity" do
    reservation = Reservation.new(
      table: table,
      customer: customer,
      time_slot: time_slot,
      reserved_date: Date.today,
      guest_count: 5
    )
    expect(reservation).to be_invalid
  end

  it "prevents double booking" do
    Reservation.create!(
      table: table,
      customer: customer,
      time_slot: time_slot,
      reserved_date: Date.today,
      guest_count: 2
    )

    reservation2 = Reservation.new(
      table: table,
      customer: customer,
      time_slot: time_slot,
      reserved_date: Date.today,
      guest_count: 2
    )
    expect(reservation2).to be_invalid
  end
end
