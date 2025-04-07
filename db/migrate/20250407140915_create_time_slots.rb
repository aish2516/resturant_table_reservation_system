class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|
      t.string :label
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
