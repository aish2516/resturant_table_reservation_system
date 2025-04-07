class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :table_number, presence: true, uniqueness: true
  # validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :table_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :location, presence: true, inclusion: { in: %w[indoor outdoor] }
end
