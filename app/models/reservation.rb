class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :table
  belongs_to :time_slot

  validates :reserved_date, :guest_count, presence: true
  validate :check_capacity
  validate :prevent_double_booking
  validate :cancellation_window, on: :update

  def check_capacity
    if guest_count && table && guest_count > table.capacity
      errors.add(:guest_count, "exceeds the table's capacity")
    end
  end

  def prevent_double_booking
    if Reservation.where(table: table, reserved_date: reserved_date, time_slot: time_slot).where.not(id: id).exists?
      errors.add(:base, 'Table is already booked for this time slot')
    end
  end

  def cancellation_window
    return unless reserved_date_changed? || time_slot_id_changed?

    slot_time = Time.zone.parse("#{reserved_date} #{time_slot.start_time}")
    if slot_time < 1.hour.from_now
      errors.add(:base, 'Cannot modify reservation less than 1 hour before slot')
    end
  end
end
