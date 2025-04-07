FactoryBot.define do
  factory :table do
    # table_number { 1 }
    # capacity { 1 }
    # # location { "MyString" }
    # # table_number { Faker::Number.unique.between(from: 1, to: 100) }
    # # capacity { [2, 4, 6, 8].sample }
    # location { %w[indoor outdoor].sample }
    sequence(:table_number) { |n| n } # ensures unique table numbers like 1, 2, 3...
    capacity { 4 }
    location { 'indoor' }
  end
end
