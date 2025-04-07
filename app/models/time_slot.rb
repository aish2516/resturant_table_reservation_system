class TimeSlot < ApplicationRecord
  # has_many :reservations
  has_many :reservations, dependent: :destroy

  validates :label, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
	    if end_time.present? && start_time.present? && end_time <= start_time
	      errors.add(:end_time, "must be after start time")
	    end
  end
end
