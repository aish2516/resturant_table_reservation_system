FactoryBot.define do
  factory :reservation do
    customer { nil }
    table { nil }
    time_slot { nil }
    reserved_date { "2025-04-07" }
    guest_count { 1 }
    special_request { "MyText" }
  end
end
