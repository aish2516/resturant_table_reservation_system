require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  let!(:table) { Table.create!(table_number: 1, capacity: 4, location: 'indoor') }
  let!(:time_slot) { TimeSlot.create!(label: "10-12", start_time: "10:00", end_time: "12:00") }

  it "creates a reservation with smart assignment" do
    post "/reservations", params: {
      reserved_date: Date.today,
      time_slot_id: time_slot.id,
      guest_count: 3,
      smart_assign: true,
      customer: { name: "Alice", email: "alice@example.com", phone: "9999999999" }
    }

    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)["guest_count"]).to eq(3)
  end

  it "fails if no suitable table is found" do
    table.update(capacity: 2)
    post "/reservations", params: {
      reserved_date: Date.today,
      time_slot_id: time_slot.id,
      guest_count: 5,
      smart_assign: true,
      customer: { name: "Bob", email: "bob@example.com", phone: "8888888888" }
    }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
